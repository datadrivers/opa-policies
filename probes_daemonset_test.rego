package probes

daemonSetGoodProbes = {
    "apiVersion": "apps/v1",
    "kind": "DaemonSet",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "app": "helloworld"
                },
                "name": "helloworld"
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
        },
        "updateStrategy": {
            "rollingUpdate": {
                "maxUnavailable": 1
            },
            "type": "RollingUpdate"
        }
    }
}

daemonSetNoLiveness = {
    "apiVersion": "apps/v1",
    "kind": "DaemonSet",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "app": "helloworld"
                },
                "name": "helloworld"
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
        },
        "updateStrategy": {
            "rollingUpdate": {
                "maxUnavailable": 1
            },
            "type": "RollingUpdate"
        }
    }
}

daemonSetNoReadiness = {
    "apiVersion": "apps/v1",
    "kind": "DaemonSet",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "revisionHistoryLimit": 10,
        "selector": {
            "matchLabels": {
                "app": "helloworld"
            }
        },
        "template": {
            "metadata": {
                "labels": {
                    "app": "helloworld"
                },
                "name": "helloworld"
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
        },
        "updateStrategy": {
            "rollingUpdate": {
                "maxUnavailable": 1
            },
            "type": "RollingUpdate"
        }
    }
}

test_DaemonSet_probes_good {
    exceptions = []
    results := violation with input.review.object as daemonSetGoodProbes with input.parameters.excludedDaemonSets as exceptions
    count(results) == 0
}

test_DaemonSet_probes_no_readiness {
    exceptions = []
    results := violation with input.review.object as daemonSetNoReadiness with input.parameters.excludedDaemonSets as exceptions

    count(results) > 0
    results[i].msg == "The readinessProbe and livenessProbe are required."
}

test_DaemonSet_probes_no_liveness {
    exceptions = []
    results := violation with input.review.object as daemonSetNoLiveness with input.parameters.excludedDaemonSets as exceptions

    count(results) > 0
    results[i].msg == "The readinessProbe and livenessProbe are required."
}

test_DaemonSet_probes_no_readiness_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as daemonSetNoReadiness with input.parameters.excludedDaemonSets as exceptions

    count(results) == 0
}

test_DaemonSet_probes_no_liveness_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as daemonSetNoLiveness with input.parameters.excludedDaemonSets as exceptions

    count(results) == 0
}