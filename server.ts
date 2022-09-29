import { Client } from "pg";
import { config } from "dotenv";
import express from "express";
import cors from "cors";

config(); //Read .env file lines as though they were env vars.

//Call this script with the environment variable LOCAL set if you want to connect to a local db (i.e. without SSL)
//Do not set the environment variable LOCAL if you want to connect to a heroku DB.

//For the ssl property of the DB connection config, use a value of...
// false - when connecting to a local DB
// { rejectUnauthorized: false } - when connecting to a heroku DB
const herokuSSLSetting = { rejectUnauthorized: false }
const sslSetting = process.env.LOCAL ? false : herokuSSLSetting
const dbConfig = {
  connectionString: process.env.DATABASE_URL,
  ssl: sslSetting,
};

const app = express();

app.use(express.json()); //add body parser to each following route handler
app.use(cors()) //add CORS support to each following route handler

const client = new Client(dbConfig);
client.connect();


//GET all data from selected static table
app.get("/tablename/:name", async (req, res) => {
  try {    
    const acceptedTableNames = ['buildweeks','contenttypes','users','tags','recommendations']    
    const tableName = req.params.name
    if (!acceptedTableNames.includes(tableName)) {
      res.status(500).send('table does not exist')
    }    
    else {
      const tableContent = await client.query(`SELECT * FROM ${tableName}`);
      res.json(tableContent.rows);
    }
  } 
  catch(error) {
    res.status(500).send('error')
    console.error(error)
  }
});

app.post("/resources", async (req, res) => {
  try {    
    const resourceData = req.body
    const col_names = 'submitter,title,author,url,summary,recommendation_option,recommendation_text' 
    const values = [resourceData.submitter, resourceData.title, resourceData.author, resourceData.URL, resourceData.summary, resourceData.reccomendationOptions, resourceData.reccomendationText]
    const insertResponse =  await client.query(`INSERT into resources(${col_names}) VALUES($1,$2,$3,$4,$5,$6,$7) returning *`,values)
    let resp  = {};
    insertResponse.rows.map(item => {
      resp = {
        resourceID: item.resource_id,
        submitter: item.submitter,
        title: item.title,
        author: item.author,
        URL: item.url,
        timestamp: item.time_stamp,
        summary: item.summary,
        reccomendationText: item.reccomendation_text,
        reccomendationOptions: item.reccomendation_options,
      }
    })
    res.status(200).json(resp)
  } 
  catch(error) {
    res.status(500).send('error')
    console.error(error)
  }
});

app.post("/tablename/:name", async(req, res)=>{
  try {    
    const acceptedTableNames = ['buildweek_resource','content_types_resource','tag_resource']    
    const tablesData = req.body
    const tableName = req.params.name   
    if (tableName === "buildweek_resource"){
      console.log(tablesData)
      const insertResponse = await client.query(`INSERT INTO ${tableName} VALUES ($1, $2)`, [tablesData.build_week_name, tablesData.resource_id]);
      res.status(200).json(insertResponse.rows);
    }
    else if (tableName === "content_types_resource"){
      const insertResponse = await client.query(`INSERT INTO ${tableName} VALUES ($1, $2)`, [tablesData.content_type, tablesData.resource_id]);
      res.status(200).json(insertResponse.rows);
    }
    else if (tableName === "tag_resource"){
      const tagNames = tablesData.tag_name
      for (let tag of tagNames) {
        const insertResponse = await client.query(`INSERT INTO ${tableName} VALUES ($1, $2)`, [tag, tablesData.resource_id]);
      } 
      res.status(200).json("Success");
    }
    else {
        res.status(500).send('table does not exist')
    }
  } 
  catch(error) {
    res.status(500).send('error')
    console.error(error)
  }
});







//Start the server on the given port
const port = process.env.PORT;
if (!port) {
  throw 'Missing PORT environment variable.  Set it in .env file.';
}
app.listen(port, () => {
  console.log(`Server is up and running on port ${port}`);
});
