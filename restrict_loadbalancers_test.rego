package restrictLoadbalancers

loadbalancer = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "app": "helloworld"
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "ports": [
            {
                "name": "http-service",
                "port": 8080,
                "protocol": "TCP",
                "targetPort": 8080
            }
        ],
        "selector": {
            "app": "helloworld"
        },
        "type": "LoadBalancer"
    }
}

nodeport = {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "labels": {
            "app": "helloworld"
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "ports": [
            {
                "name": "http-service",
                "port": 8080,
                "protocol": "TCP",
                "targetPort": 8080
            }
        ],
        "selector": {
            "app": "helloworld"
        },
        "type": "NodePort"
    }
}

test_unallowed_Loadbalancer {
    services := ["istio-ingressgateway"]
    results := violation with input.review.object as loadbalancer with input.parameters.approvedServices as services
    count(results) > 0
    results[i].msg == "This service with type Loadbalancer is not allowed."
}

test_allowed_Loadbalancer {
    services := ["helloworld"]
    results := violation with input.review.object as loadbalancer with input.parameters.approvedServices as services
    count(results) == 0
}

test_unallowed_NodePort {
    services := ["istio-ingressgateway"]
    results := violation with input.review.object as nodeport with input.parameters.approvedServices as services
    count(results) > 0
    results[i].msg == "This service with type NodePort is not allowed."
}

test_allowed_NodePort {
    services := ["helloworld"]
    results := violation with input.review.object as nodeport with input.parameters.approvedServices as services
    count(results) == 0
}
