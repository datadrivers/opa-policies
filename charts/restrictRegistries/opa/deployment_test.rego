package restrictRegistries

deployment = {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "minReadySeconds": 30,
        "progressDeadlineSeconds": 600,
        "replicas": 3,
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
        },
        "strategy": {
            "rollingUpdate": {
                "maxSurge": 2,
                "maxUnavailable": 0
            },
            "type": "RollingUpdate"
        },
        "template": {
            "metadata": {
                "labels": {
                    "app": "helloworld",
                }
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
    }
}

test_unallowed_Deployment {
    registries := ["eu.gcr.io/test"]
    results := violation with input.review.object as deployment with input.parameters.approvedRegistries as registries

    count(results) > 0
    results[i].msg == "Container <init> has an invalid image repo <eu.gcr.io/cicd/helloworld_init:v1.0.0>, allowed repos are eu.gcr.io/test"
}

test_allowed_Deployment {
    registries := ["eu.gcr.io/test", "eu.gcr.io/cicd"]
    results := violation with input.review.object as deployment with input.parameters.approvedRegistries as registries
    count(results) == 0
}
