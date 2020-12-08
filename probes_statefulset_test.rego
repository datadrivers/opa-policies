package probes

statefulSetGoodProbes = {
    "apiVersion": "apps/v1",
    "kind": "StatefulSet",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "replicas": 3,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
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
                        "image": "eu.gcr.io/test/helloworld_server",
                        "imagePullPolicy": "Always",
                        "name": "helloworld",
                        "livenessProbe": {
                            "failureThreshold": 4,
                            "httpGet": {
                                "path": "/healthz/live",
                                "port": 15020,
                                "scheme": "HTTP"
                            },
                            "initialDelaySeconds": 20,
                            "periodSeconds": 10,
                            "successThreshold": 1,
                            "timeoutSeconds": 1
                        },
                        "readinessProbe": {
                            "failureThreshold": 30,
                            "httpGet": {
                                "path": "/healthz/ready",
                                "port": 15020,
                                "scheme": "HTTP"
                            },
                            "initialDelaySeconds": 1,
                            "periodSeconds": 2,
                            "successThreshold": 1,
                            "timeoutSeconds": 1
                        },
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
                ],
                "nodeSelector": {
                    "service-pool": "true"
                },
            }
        },
        "updateStrategy": {
            "type": "OnDelete"
        },
    }
}

statefulSetNoLiveness = {
    "apiVersion": "apps/v1",
    "kind": "StatefulSet",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "replicas": 3,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
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
                        "image": "eu.gcr.io/test/helloworld_server",
                        "imagePullPolicy": "Always",
                        "name": "helloworld",
                        "readinessProbe": {
                            "failureThreshold": 30,
                            "httpGet": {
                                "path": "/healthz/ready",
                                "port": 15020,
                                "scheme": "HTTP"
                            },
                            "initialDelaySeconds": 1,
                            "periodSeconds": 2,
                            "successThreshold": 1,
                            "timeoutSeconds": 1
                        },
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
                ],
                "nodeSelector": {
                    "service-pool": "true"
                },
            }
        },
        "updateStrategy": {
            "type": "OnDelete"
        },
    }
}

statefulSetNoReadiness = {
    "apiVersion": "apps/v1",
    "kind": "StatefulSet",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "replicas": 3,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
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
                        "image": "eu.gcr.io/test/helloworld_server",
                        "imagePullPolicy": "Always",
                        "name": "helloworld",
                        "livenessProbe": {
                            "failureThreshold": 4,
                            "httpGet": {
                                "path": "/healthz/live",
                                "port": 15020,
                                "scheme": "HTTP"
                            },
                            "initialDelaySeconds": 20,
                            "periodSeconds": 10,
                            "successThreshold": 1,
                            "timeoutSeconds": 1
                        },
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
                ],
                "nodeSelector": {
                    "service-pool": "true"
                },
            }
        },
        "updateStrategy": {
            "type": "OnDelete"
        },
    }
}

test_StatefulSet_probes_good {
    exceptions = []
    results := violation with input.review.object as statefulSetGoodProbes with input.parameters.excludedStatefulSets as exceptions
    count(results) == 0
}

test_StatefulSet_probes_no_readiness {
    exceptions = []
    results := violation with input.review.object as statefulSetNoReadiness with input.parameters.excludedStatefulSets as exceptions

    count(results) > 0
    results[i].msg == "The readinessProbe and livenessProbe are required."
}

test_StatefulSet_probes_no_liveness {
    exceptions = []
    results := violation with input.review.object as statefulSetNoLiveness with input.parameters.excludedStatefulSets as exceptions

    count(results) > 0
    results[i].msg == "The readinessProbe and livenessProbe are required."
}

test_StatefulSet_probes_no_readiness_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as statefulSetNoReadiness with input.parameters.excludedStatefulSets as exceptions

    count(results) == 0
}

test_StatefulSet_probes_no_liveness_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as statefulSetNoLiveness with input.parameters.excludedStatefulSets as exceptions

    count(results) == 0
}