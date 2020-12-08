package containerResources

statefulSetGoodResources = {
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

statefulSetNoCpuLimit = {
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

statefulSetNoCpuRequest = {
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

statefulSetNoMemoryLimit = {
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
                                "cpu": "250m"
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

statefulSetNoMemoryRequest = {
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
                                "cpu": "50m"
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

test_StatefulSet_resources_good {
    exceptions = []
    results := violation with input.review.object as statefulSetGoodResources with input.parameters.excludedStatefulSets as exceptions
    count(results) == 0
}

test_StatefulSet_resources_no_cpu_limit {
    exceptions = []
    results := violation with input.review.object as statefulSetNoCpuLimit with input.parameters.excludedStatefulSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_StatefulSet_resources_no_cpu_request {
    exceptions = []
    results := violation with input.review.object as statefulSetNoCpuRequest with input.parameters.excludedStatefulSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_StatefulSet_resources_no_ram_limit {
    exceptions = []
    results := violation with input.review.object as statefulSetNoMemoryLimit with input.parameters.excludedStatefulSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_StatefulSet_resources_no_ram_request {
    exceptions = []
    results := violation with input.review.object as statefulSetNoMemoryRequest with input.parameters.excludedStatefulSets as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}


test_StatefulSet_resources_no_cpu_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as statefulSetNoCpuLimit with input.parameters.excludedStatefulSets as exceptions

    count(results) == 0
}

test_StatefulSet_resources_no_cpu_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as statefulSetNoCpuRequest with input.parameters.excludedStatefulSets as exceptions

    count(results) == 0
}

test_StatefulSet_resources_no_ram_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as statefulSetNoMemoryLimit with input.parameters.excludedStatefulSets as exceptions

    count(results) == 0
}

test_StatefulSet_resources_no_ram_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as statefulSetNoMemoryRequest with input.parameters.excludedStatefulSets as exceptions

    count(results) == 0
}