const assert = require('assert');
const axios = require('axios');

const remoteHost = 'http://10-222-74-69.ssnc-corp.cloud/graphql' 
const headers = { 'Content-Type': 'application/json'}

const check =  async () =>{ 
    const response = await axios.default.post(remoteHost,"",{
        headers,
        data:JSON.stringify({
            query:`query{
                sample
            }`
        })
    });
    if(response.status == 200 || response.status == 201 || response.statusText){
        console.log('ubernetes cluster is set up');
    }else{
        console.log('ubernetes cluster not  set up');
        process.exit(1);
    }
}
