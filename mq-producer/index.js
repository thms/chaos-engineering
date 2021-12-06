use 'strict';

// MQ Producer: sends a single essage to the MQ server
// Import the MQ package
var mq = require('ibmmq');
var MQC = mq.MQC; // Want to refer to this export directly for simplicity

// The queue manager and queue to be used. These can be overridden on command line.
var qMgr = "QM1";
var qName = "DEV.QUEUE.1";
var hConn;


function formatErr(err) {
  return  "MQ call failed in " + err.message;
}

function toHexString(byteArray) {
  return byteArray.reduce((output, elem) =>
    (output + ('0' + elem.toString(16)).slice(-2)),
    '');
}

// Define some functions that will be used from the main flow
function putMessage(hObj) {

  var msg = "Hello from Node at " + new Date();

  var mqmd = new mq.MQMD(); // Defaults are fine.
  var pmo = new mq.MQPMO();

  // Describe how the Put should behave
  pmo.Options = MQC.MQPMO_NO_SYNCPOINT |
                MQC.MQPMO_NEW_MSG_ID |
                MQC.MQPMO_NEW_CORREL_ID;

  mq.Put(hObj,mqmd,pmo,msg,function(err) {
    if (err) {
      console.log(formatErr(err));
    } else {
      console.log("MsgId: " + toHexString(mqmd.MsgId));
      console.log("MQPUT successful");
    }
  });
}

// When we're done, close queues and connections
function cleanup(hConn) {
}

function sleep(ms) {
  return new Promise(resolve=>{
    setTimeout(resolve,ms);
  });
}

// The program really starts here.
// Connect to the queue manager. If that works, the callback function
// opens the queue, and then we can put a message.

console.log("Sample AMQSCONN.JS start");

// Create default MQCNO structure
var cno = new mq.MQCNO();

// Add authentication via the MQCSP structure
var csp = new mq.MQCSP();
csp.UserId = "app";
csp.Password = "passw0rd";
// Make the MQCNO refer to the MQCSP
// This line allows use of the userid/password
cno.SecurityParms = csp;

// And use the MQCD to programatically connect as a client
// First force the client mode
cno.Options |= MQC.MQCNO_CLIENT_BINDING;
// And then fill in relevant fields for the MQCD
var cd = new mq.MQCD();
cd.ConnectionName = "localhost(1414)";
cd.ChannelName = "DEV.APP.SVRCONN";
// Make the MQCNO refer to the MQCD
cno.ClientConn = cd;

// MQ V9.1.2 allows setting of the application name explicitly
if (MQC.MQCNO_CURRENT_VERSION >= 7) {
  cno.ApplName = "Node.js 9.1.2 ApplName";
}

// connect and put message onto the queue
mq.Connx(qMgr, cno, function(err,hConn) {
   if (err) {
     console.log(formatErr(err));
   } else {
     console.log("MQCONN to %s successful ", qMgr);

     // Define what we want to open, and how we want to open it.
     var od = new mq.MQOD();
     od.ObjectName = qName;
     od.ObjectType = MQC.MQOT_Q;
     var openOptions = MQC.MQOO_OUTPUT;
     mq.Open(hConn,od,openOptions,function(err,hObj) {
       if (err) {
         console.log(formatErr(err));
       } else {
         console.log("MQOPEN of %s successful",qName);
         putMessage(hObj);
       }
       cleanup(hConn,hObj);
     });
   }
});

// Now we can try to connect and discover stuff
// mq.Connx(qMgr, cno, function(err,conn) {
//   if (err) {
//     console.log(formatErr(err));
//   } else {
//     console.log("MQCONN to %s successful ", qMgr);
//     // Sleep for a few seconds - bad in a real program but good for this one
//     sleep(3 *1000).then(() => {
//       mq.Disc(conn, function(err) {
//         if (err) {
//           console.log(formatErr(err));
//         } else {
//           console.log("MQDISC successful");
//         }
//       });
//     });
//   }
// });
