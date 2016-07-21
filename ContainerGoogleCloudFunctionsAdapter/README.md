# Manager Public Google Cloud Functions

You have to build and run the docker container manually:
* change to directory ```ContainerGoogleCloudFunctionsAdapter```
* execute ```docker build -t <containerImageName> .```
* execute ```docker run -p 50005:50005 -it <containerImageName> bash``` (now you are in the container)
* execute ```gcloud init``` and follow the instructions (answer "configure compute engine" with no)
* start the api adapter ```/fapra/main.js```

These steps are required, because Google Cloud Functions has no automated way of
authentication.

The API adapter provides methods to
* create a bucket
* delete a bucket
* deploy a function
* get status of function
* view logs

Create and delete bucket does not send any response, because Googles Cloud Functions
platform does not send any response for this methods.
