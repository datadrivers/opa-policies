package restrictRegistries

pod = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld-9b8596599-b4mvk",
        "namespace": "platform",
    },
    "spec": {
        "containers": [
            {
                "env": [
                    {
                        "name": "VAR",
                        "value": "value"
                    }
                ],
                "envFrom": [
                    {
                        "configMapRef": {
                            "name": "configMap"
                        }
                    }
                ],
                "image": "eu.gcr.io/test/helloworld_server",
                "imagePullPolicy": "Always",
                "name": "helloworld",
                "resources": {
                    "limits": {
                        "cpu": "250m",
                        "memory": "512Mi"
                    },
                    "requests": {
                        "cpu": "50m",
                        "memory": "256Mi"
                    }
                }
            }
        ]
    }
}

podInit = {
    "apiVersion": "v1",
    "kind": "Pod",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld-9b8596599-b4mvk",
        "namespace": "platform",
    },
    "spec": {
        "containers": [
            {
                "env": [
                    {
                        "name": "VAR",
                        "value": "value"
                    }
                ],
                "envFrom": [
                    {
                        "configMapRef": {
                            "name": "configMap"
                        }
                    }
                ],
                "image": "eu.gcr.io/test/helloworld_server",
                "imagePullPolicy": "Always",
                "name": "helloworld",
                "resources": {
                    "limits": {
                        "cpu": "250m",
                        "memory": "512Mi"
                    },
                    "requests": {
                        "cpu": "50m",
                        "memory": "256Mi"
                    }
                }
            },
            {
                
                "env": [
                    {
                        "name": "POD_NAME",
                        "valueFrom": {
                            "fieldRef": {
                                "apiVersion": "v1",
                                "fieldPath": "metadata.name"
                            }
                        }
                    }
                ],
                "image": "eu.gcr.io/test/helloworld_client",
                "name": "helloworld_client",
                
            }
        ],
        "initContainers": [
            {
                "image": "eu.gcr.io/cicd/helloworld_init:v1.0.0",
                "name": "init",
                
            }
        ],
        "nodeSelector": {
            "service-pool": "true"
        },
    }
}

test_unallowed_container_Pod {
    registries := ["eu.gcr.io/cicd"]
    results := violation with input.review.object as pod with input.parameters.approvedRegistries as registries

    count(results) == 1
    results[i].msg == "Container <helloworld> has an invalid image repo <eu.gcr.io/test/helloworld_server>, allowed repos are eu.gcr.io/cicd"
}

test_unallowed_initContainer_Pod {
    registries := ["eu.gcr.io/test", "test/test"]
    results := violation with input.review.object as podInit with input.parameters.approvedRegistries as registries

    count(results) == 1
    results[i].msg == "Container <init> has an invalid image repo <eu.gcr.io/cicd/helloworld_init:v1.0.0>, allowed repos are eu.gcr.io/test, test/test"
}

test_allowed_Pod {
    registries := ["eu.gcr.io/test", "eu.gcr.io/cicd"]
    results := violation with input.review.object as pod with input.parameters.approvedRegistries as registries
    count(results) == 0
}
