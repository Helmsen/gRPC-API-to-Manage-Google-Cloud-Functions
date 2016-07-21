# gRPC API to Manage Google Cloud Functions

The Manage Google Cloud Functions API adapter provides methods to
* create a bucket
* delete a bucket
* deploy a function
* get status of function
* view logs

Create and delete bucket does not send any response, because Googles Cloud Functions
platform does not send any response for this methods.

There is a preconfigured docker-compose test scenario. Before running it, you have
to build and run a docker container containing the API adapter manually:
* change to directory ```ContainerGoogleCloudFunctionsAdapter```
* execute ```docker build -t <containerImageName> .```
* execute ```docker run -p 50005:50005 -it <containerImageName> bash``` (now you are in the container)
* execute ```gcloud init``` and follow the instructions (answer "configure compute engine" with no)
* start the api adapter ```/fapra/main.js```

These steps are required, because Google Cloud Functions has no automated way of
authentication. Further you have to provide some information in the compose file:
* Set environment variable API_HOST to the IP of the containers network
interface or the network interface of the docker host
* Add the name of a existing project of your Google Cloud Functions account to "command"

The parts of the compose file you have to change are annotated with TODO-comments.
Finally run the test scenario with ```docker-compose up --build <pathToComposeFile>```.
