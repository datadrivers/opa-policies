package containerResources

contains_element(arr, elem) = true {
    arr[_] = elem
} else = false { true }

contains_resources(container) = true {
    container.resources.limits.cpu
    container.resources.requests.cpu
    container.resources.limits.memory
    container.resources.requests.memory
} else = false { true }

# Check for Resources
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Deployment"
    not contains_element(input.parameters.excludedDeployments, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_] 
    not contains_resources(container)
    msg := "The resource limits and requests are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "StatefulSet"
    not contains_element(input.parameters.excludedStatefulSets, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_] 
    not contains_resources(container)
    msg := "The resource limits and requests are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "DaemonSet"
    not contains_element(input.parameters.excludedDaemonSets, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_] 
    not contains_resources(container)
    msg := "The resource limits and requests are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Job"
    not contains_element(input.parameters.excludedJobs, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_] 
    not contains_resources(container)
    msg := "The resource limits and requests are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "CronJob"
    not contains_element(input.parameters.excludedCronJobs, input.review.object.metadata.name)
    container = input.review.object.spec.jobTemplate.spec.template.spec.containers[_]
    not contains_resources(container)
    msg := "The resource limits and requests are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Pod"
    not contains_element(input.parameters.excludedPods, input.review.object.metadata.name)
    container = input.review.object.spec.containers[_] 
    not contains_resources(container)
    msg := "The resource limits and requests are required."
}
