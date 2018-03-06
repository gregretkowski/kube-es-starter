
This is the Docker & Kubernetes config that accompanies my blog post
on *Deploying ML workloads with Azure and Kubernetes* *Link coming soon*

![Humaniod Learning Task](humanoid.jpg?raw=true)

You should first create the docker container image and test locally..

    cd docker
    docker build -t gretkowski/kubeevo:v1 -f Dockerfile .

make sure everything is good w/ the container image, then push it to your
private image registry.

You then use the rest of the YAML files - modified to suit your environment -
to deploy the master and worker containers to your Kubernetes cluster
