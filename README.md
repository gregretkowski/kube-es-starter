
This is the Docker & Kubernetes config that accompanies my blog post [Deploying ML workloads with Azure and Kubernetes](http://www.rage.net/~greg/2018-03-05-kube-azure-es-roboschool.html).

This uses the [Evolution Strategies](https://github.com/openai/evolution-strategies-starter) starter and [Roboschool](https://github.com/openai/roboschool).

![Humaniod Learning Task](humanoid.jpg?raw=true)

You should first create the docker container image and test locally..

    cd docker
    docker build -t gretkowski/kubeevo:v1 -f Dockerfile .

make sure everything is good w/ the container image, then push it to your
private image registry.

You then use the rest of the YAML files - modified to suit your environment -
to deploy the master and worker containers to your Kubernetes cluster
