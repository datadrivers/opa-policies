package containerResources

cronJobGoodResources = {
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

cronJobNoCpuLimit = {
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
                        ]
                    }
                }
            }
        },
        "schedule": "0 1 * * *",
    },
}

cronJobNoCpuRequest = {
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
                        ]
                    }
                }
            }
        },
        "schedule": "0 1 * * *",
    },
}

cronJobNoMemoryLimit = {
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
                                "image": "eu.gcr.io/test/helloworld_server",
                                "imagePullPolicy": "Always",
                                "name": "helloworld",
                                "resources": {
                                    "limits": {
                                        "cpu": "250m",
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

cronJobNoMemoryRequest = {
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

test_CronJob_resources_good {
    exceptions = []
    results := violation with input.review.object as cronJobGoodResources with input.parameters.excludedCronJobs as exceptions
    count(results) == 0
}

test_CronJob_resources_no_cpu_limit {
    exceptions = []
    results := violation with input.review.object as cronJobNoCpuLimit with input.parameters.excludedCronJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_CronJob_resources_no_cpu_request {
    exceptions = []
    results := violation with input.review.object as cronJobNoCpuRequest with input.parameters.excludedCronJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_CronJob_resources_no_ram_limit {
    exceptions = []
    results := violation with input.review.object as cronJobNoMemoryLimit with input.parameters.excludedCronJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_CronJob_resources_no_ram_request {
    exceptions = []
    results := violation with input.review.object as cronJobNoMemoryRequest with input.parameters.excludedCronJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_CronJob_resources_no_cpu_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as cronJobNoCpuLimit with input.parameters.excludedCronJobs as exceptions

    count(results) == 0
}

test_CronJob_resources_no_cpu_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as cronJobNoCpuRequest with input.parameters.excludedCronJobs as exceptions

    count(results) == 0
}

test_CronJob_resources_no_ram_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as cronJobNoMemoryLimit with input.parameters.excludedCronJobs as exceptions

    count(results) == 0
}

test_CronJob_resources_no_ram_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as cronJobNoMemoryRequest with input.parameters.excludedCronJobs as exceptions

    count(results) == 0
}