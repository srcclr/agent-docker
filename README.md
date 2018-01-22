# Running SourceClear on Windows*
#### \**(aka - Running SourceClear in a Docker container)*

**Author:** Jet Anderson <jet@sourceclear.com>  
**github:** https://github.com/srcclr/agent-docker-example  


## Why do we need this?

Given that our primary focus is running SourceClear in DevSecOps pipelines, the SourceClear  agent currently doesn't run on Windows. However, that shouldn't stop you from running SourceClear scans on your Windows development desktops or Windows build servers. In fact, there are a lot of reasons why building your project in a container and running your tests therein makes even more sense than running it locally.

#### Container based builds:####
 - Create a repeatable process that anyone can duplicate. A **Dockerfile** works the same across all systems.
 - You can version your **Dockerfile**
 - Makes it portable to a new build system


#### Planning your container build
- In the **FROM** section choose an image with MINIMUM REQUIREMENTS to build your project. This is a best practice both for security and image size management.
- Add only programs needed to build your app, add these as **RUN** sections. In our case we add ```pip``` and ```curl```.
- Use **ADD** or **COPY** to make a copy of your app into the container for build and scanning. For our example we placed an app in a "vulnerable_app" folder at the container definition root and copied it into a /home/app directory.  
- Install dependencies for your application
- Set the **SRCCLR_API_TOKEN** variable *(we've used an ENV variable for ease, but you can optionally set this with docker-compose if you wish)*



### How to use the example

**NOTE:** Rename 'Dockerfile.example' to 'Dockerfile' before using.  
\* *For more information on the SourceClear CI script see below link.*

Use the following commands to run your container build:

```
# First build the image
$ docker build . -t your_tag_name

# Now run the built image
$ docker run your_tag_name
```



##### Resources
For SourceClear CI script usage see:
- https://www.sourceclear.com/docs/ci-script-usage/

Based on a similar project from:
- https://github.com/embrasure/srcclr/

For a simple vulnerable Python example app to scan use:
- https://github.com/gdemarcsek/vulnerable
