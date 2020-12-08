package containerResources

daemonSetGoodResources = {
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

daemonSetNoCpuLimit = {
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

daemonSetNoCpuRequest = {
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

daemonSetNoMemoryLimit = {
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
                                "cpu": "250m"
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

daemonSetNoMemoryRequest = {
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
                                "cpu": "50m"
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

test_DaemonSet_resources_good {
    exceptions = []
    results := violation with input.review.object as daemonSetGoodResources with input.parameters.excludedDaemonSets as exceptions
    count(results) == 0
}

test_DaemonSet_resources_no_cpu_limit {
    exceptions = []
    results := violation with input.review.object as daemonSetNoCpuLimit with input.parameters.excludedDaemonSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_DaemonSet_resources_no_cpu_request {
    exceptions = []
    results := violation with input.review.object as daemonSetNoCpuRequest with input.parameters.excludedDaemonSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_DaemonSet_resources_no_ram_limit {
    exceptions = []
    results := violation with input.review.object as daemonSetNoMemoryLimit with input.parameters.excludedDaemonSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_DaemonSet_resources_no_ram_request {
    exceptions = []
    results := violation with input.review.object as daemonSetNoMemoryRequest with input.parameters.excludedDaemonSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_DaemonSet_resources_no_cpu_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as daemonSetNoCpuLimit with input.parameters.excludedDaemonSets as exceptions

    count(results) == 0
}

test_DaemonSet_resources_no_cpu_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as daemonSetNoCpuRequest with input.parameters.excludedDaemonSets as exceptions

    count(results) == 0
}

test_DaemonSet_resources_no_ram_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as daemonSetNoMemoryLimit with input.parameters.excludedDaemonSets as exceptions

    count(results) == 0
}

test_DaemonSet_resources_no_ram_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as daemonSetNoMemoryRequest with input.parameters.excludedDaemonSets as exceptions

    count(results) == 0
}