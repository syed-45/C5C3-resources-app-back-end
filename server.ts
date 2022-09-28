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
app.get("/resources", async (req,res)=>{
  try{
    const getResources= await client.query('SELECT * from resources');
    res.json(getResources.rows)
  }
  catch(error){
    res.status(500).send("Error");
    console.log(error)
  }
}); 

app.get("/resources/comments/:resourceid", async (req, res)=>{
  try{
    const {resourceId}= req.params;
    const getComments = await client.query('select * from comment_inputs where resource_id=$1',[resourceId])
    res.json(getComments.rows)
  }
  catch(error){
    res.status(500).send("Error");
    console.log(error)
  }
})

app.post("/resources", async (req, res) => {
  try {    
    const resourceData = req.body
    const col_names = 'submitter,title,author,url,summary,recommendation_option,recommendation_text' 
    const values = [resourceData.submitter, resourceData.title, resourceData.author, resourceData.url, resourceData.summary, resourceData.recommendation_option, resourceData.recommendation_text]
    const insertResponse =  await client.query(`INSERT into  resources(${col_names}) VALUES($1,$2,$3,$4,$5,$6,$7) returning *`,values)
    res.json(insertResponse.rows)
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
