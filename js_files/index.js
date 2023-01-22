const express = require("express");
const mongoose = require("mongoose");

mongoose.connect("mongodb://127.0.0.1:27017/myapp",{
    useNewUrlParser : true,
    
    useUnifiedTopology  : true,    

});

const port = process.env.PORT || 5000;
const app = express();

const connection = mongoose.connection;
connection.once("open",() => {
    console.log("mongodb connected");
});

app.use(express.json());
const userRoute = require("../routes/user");
app.use("/user",userRoute);

app.route("/").get((req,res) =>res.json("your first rest api  xdc"));

app.listen(port, () =>console.log('your server is running on port ${port}'));

