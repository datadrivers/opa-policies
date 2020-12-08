package restrictRegistries

cronjob = {
    "apiVersion": "batch/v1",
    "kind": "CronJob",
    "metadata": {
        "name": "helloworld",
        "namespace": "default",
    },
    "spec": {
        "jobTemplate": {
            "spec": {
                "template": {
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
            }
        },
        "schedule": "0 1 * * *",
    },
}


cronjobInit = {
    "apiVersion": "batch/v1",
    "kind": "CronJob",
    "metadata": {
        "name": "helloworld",
        "namespace": "default",
    },
    "spec": {
        "jobTemplate": {
            "spec": {
                "template": {
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
        },
        "schedule": "0 1 * * *",
    },
}

test_unallowed_container_CronJob {
    registries := ["eu.gcr.io/cicd"]
    results := violation with input.review.object as cronjob with input.parameters.approvedRegistries as registries

    count(results) > 0
    results[i].msg == "Container <helloworld> has an invalid image repo <eu.gcr.io/test/helloworld_server>, allowed repos are eu.gcr.io/cicd"
}

test_unallowed_initContainer_CronJob {
    registries := ["eu.gcr.io/test"]
    results := violation with input.review.object as cronjobInit with input.parameters.approvedRegistries as registries

    count(results) > 0
    results[i].msg == "Container <init> has an invalid image repo <eu.gcr.io/cicd/helloworld_init:v1.0.0>, allowed repos are eu.gcr.io/test"
}

test_allowed_CronJob {
    registries := ["eu.gcr.io/test", "eu.gcr.io/cicd"]
    results := violation with input.review.object as cronjob with input.parameters.approvedRegistries as registries
    count(results) == 0
}
