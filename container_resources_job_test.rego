package containerResources

jobGoodResources  = {
    "apiVersion": "batch/v1",
    "kind": "Job",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "activeDeadlineSeconds": 100,
        "backoffLimit": 1,
        "completions": 1,
        "parallelism": 1,
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
    }
}

jobNoCpuLimit  = {
    "apiVersion": "batch/v1",
    "kind": "Job",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "activeDeadlineSeconds": 100,
        "backoffLimit": 1,
        "completions": 1,
        "parallelism": 1,
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
    }
}

jobNoCpuRequest  = {
    "apiVersion": "batch/v1",
    "kind": "Job",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "activeDeadlineSeconds": 100,
        "backoffLimit": 1,
        "completions": 1,
        "parallelism": 1,
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
    }
}

jobNoMemoryLimit  = {
    "apiVersion": "batch/v1",
    "kind": "Job",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "activeDeadlineSeconds": 100,
        "backoffLimit": 1,
        "completions": 1,
        "parallelism": 1,
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
    }
}

jobNoMemoryRequest  = {
    "apiVersion": "batch/v1",
    "kind": "Job",
    "metadata": {
        "labels": {
            "app": "helloworld",
        },
        "name": "helloworld",
        "namespace": "platform",
    },
    "spec": {
        "activeDeadlineSeconds": 100,
        "backoffLimit": 1,
        "completions": 1,
        "parallelism": 1,
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
    }
}

test_Job_resources_good {
    exceptions = []
    results := violation with input.review.object as jobGoodResources with input.parameters.excludedJobs as exceptions
    count(results) == 0
}

test_Job_resources_no_cpu_limit {
    exceptions = []
    results := violation with input.review.object as jobNoCpuLimit with input.parameters.excludedJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Job_resources_no_cpu_request {
    exceptions = []
    results := violation with input.review.object as jobNoCpuRequest with input.parameters.excludedJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Job_resources_no_ram_limit {
    exceptions = []
    results := violation with input.review.object as jobNoMemoryLimit with input.parameters.excludedJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Job_resources_no_ram_request {
    exceptions = []
    results := violation with input.review.object as jobNoMemoryRequest with input.parameters.excludedJobs as exceptions

    count(results) > 0
    results[i].msg == "The resource limits and requests are required."
}

test_Job_resources_no_cpu_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as jobNoCpuLimit with input.parameters.excludedJobs as exceptions

    count(results) == 0
}

test_Job_resources_no_cpu_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as jobNoCpuRequest with input.parameters.excludedJobs as exceptions

    count(results) == 0
}

test_Job_resources_no_ram_limit_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as jobNoMemoryLimit with input.parameters.excludedJobs as exceptions

    count(results) == 0
}

test_Job_resources_no_ram_request_exception {
    exceptions = ["helloworld"]
    results := violation with input.review.object as jobNoMemoryRequest with input.parameters.excludedJobs as exceptions

    count(results) == 0
}