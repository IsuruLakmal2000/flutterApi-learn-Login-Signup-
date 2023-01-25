const express = require("express");
const usersModels = require("../models/users.models");
const User = require("../models/users.models");
const config =require("../config");
const jwt =require("jsonwebtoken");


const router = express.Router();    

router.route("/register/").post((req,res) => {
    console.log("inside the register");
    const user = new User({
        username : req.body.username,
        password : req.body.password,
        email : req.body.cpassword,
    });
    user
        .save()
        .then(()=>{
            console.log("User registered");
            res.status(200).json("ok");

        })
        .catch((err)=>{
            res.status(403).json({msg:err});
        });

        
    
    
});

router.route("/update/:username").patch((req,res) =>{
    User.findOneAndUpdate(
        {username :req.params.username},
        {$set : {password:req.body.password}},
        (err,result) =>{
            if(err) return res.status(500).json({msg:err});
            const msg = {
                msg : "password successfully updated!",
                username : req.params.username,
                

            };
            return res.json(msg);
        }
    );
});


 

router.route("/delete/:username").delete((req,res)=>{
    User.findOneAndDelete(
        {username :req.params.username},
        (err,result)=>{
            if(err) return res.status(500).json({msg:err});
            const msg = {
                msg : "msg was deleted",
                username :req.params.username,

            };
            return res.json(msg);
        }
    );
});

router.route("/:username").get((req,res)=>{
    User.findOne({username: req.params.username},(err,result)=>{
            if(err) res.status(500).json({msg:err});
            res.json({
                data:result,
                username: req.params.username,
            });
    });
});


router.route("/checkusername/:username").get((req,res)=>{
    User.findOne({username:req.params.username},(err,result)=>{
        // if(err) return res.status(500).json({msg:err});
        if(result==null){
            return res.json({
                status :true,
            });
        }
        else{
            return res.json({
                status :false,
            });
        }
    });
});


router.route("/login").post((req,res)=>{
    usersModels.findOne({username: req.body.username},(err,result)=>{
        if(err) return res.status(500).json({msg:err});
        if(result==null){
            return res.status(403).json("either username incorrect")
        }
        if(result.password == req.body.password){
           
            let token = jwt.sign({username:req.body.username},config.key,{
                expiresIn: "24h",
            }); 
            res.json({
                token:token,
                msg : "success",
            })
        }
        else{
            res.status(403).json("password incorrect")
        }
    });
});

module.exports = router;1