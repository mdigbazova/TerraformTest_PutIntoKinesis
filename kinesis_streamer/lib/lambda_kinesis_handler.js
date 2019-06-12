// applications/Kinesis_streamer/lib/handler.js

import AWS from 'aws-sdk';
const Kinesis = new AWS.Kinesis();

export function receiveEvent(event, context, callback) {
  console.log('testHandler');
  console.log('Event: ${JSON.stringify(event, null, 2)}');
  console.log('Context: ${JSON.stringify(context, null, 2)}');
  const base64Data = event.Records[0].Kinesis.data;
  const base64Decoded = new Buffer(base64Data, 'base64').toString()
  console.log(base64Decoded);
  return callback();
}

export function publishEvent(event, context, callback) {
  console.log('testHandler');
  console.log('Event: ${JSON.stringify(event, null, 2)}');
  console.log('Context: ${JSON.stringify(context, null, 2)}');

  const params = {
    Data: '{ sample: "json-object" }',
    PartitionKey: 'resource-1',
    StreamName: 'terraform-kinesis-streamer-test-stream'
  };

  console.log('putting Kinesis record');
  Kinesis.putRecord(params, (err, data) => {
    if (err) {
      console.error('error putting Kinesis record');
      console.error(err);
      return callback(err);
    }

    console.log('Kinesis put success');
    console.log(JSON.stringify(data, null, 2));
    return callback();
  });
}