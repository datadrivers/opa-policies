package containerResources

podGoodResources = {
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
        ],
        "nodeSelector": {
            "service-pool": "true"
        },
    }
}

podNoCpuLimit = {
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
                "image": "eu.gcr.io/test/helloworld_server",
                "imagePullPolicy": "Always",
                "name": "helloworld",
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
}

podNoCpuRequest = {
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
                "image": "eu.gcr.io/test/helloworld_server",
                "imagePullPolicy": "Always",
                "name": "helloworld",
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
}

podNoMemoryLimit = {
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
                "image": "eu.gcr.io/test/helloworld_server",
                "imagePullPolicy": "Always",
                "name": "helloworld",
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
}

podNoMemoryRequest = {
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
                "image": "eu.gcr.io/test/helloworld_server",
                "imagePullPolicy": "Always",
                "name": "helloworld",
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
}

test_Pod_resources_good {
    exceptions = []
    results := violation with input.review.object as podGoodResources with input.parameters.excludedPods as exceptions
    count(results) == 0
}

test_Pod_resources_no_cpu_limit {
    exceptions = []
    results := violation with input.review.object as podNoCpuLimit with input.parameters.excludedPods as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Pod_resources_no_cpu_request {
    exceptions = []
    results := violation with input.review.object as podNoCpuRequest with input.parameters.excludedPods as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Pod_resources_no_ram_limit {
    exceptions = []
    results := violation with input.review.object as podNoMemoryLimit with input.parameters.excludedPods as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Pod_resources_no_ram_request {
    exceptions = []
    results := violation with input.review.object as podNoMemoryRequest with input.parameters.excludedPods as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Pod_resources_no_cpu_limit_exception {
    exceptions = ["helloworld-9b8596599-b4mvk"]
    results := violation with input.review.object as podNoCpuLimit with input.parameters.excludedPods as exceptions

    count(results) == 0
}

test_Pod_resources_no_cpu_request_exception {
    exceptions = ["helloworld-9b8596599-b4mvk"]
    results := violation with input.review.object as podNoCpuRequest with input.parameters.excludedPods as exceptions

    count(results) == 0
}

test_Pod_resources_no_ram_limit_exception {
    exceptions = ["helloworld-9b8596599-b4mvk"]
    results := violation with input.review.object as podNoMemoryLimit with input.parameters.excludedPods as exceptions

    count(results) == 0
}

test_Pod_resources_no_ram_request_exception {
    exceptions = ["helloworld-9b8596599-b4mvk"]
    results := violation with input.review.object as podNoMemoryRequest with input.parameters.excludedPods as exceptions

    count(results) == 0
}