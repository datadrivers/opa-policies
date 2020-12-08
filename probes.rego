package probes

contains_element(arr, elem) = true {
    arr[_] = elem
} else = false { true }

contains_probes(container) = true {
    container.readinessProbe
    container.livenessProbe
} else = false { true }

# Check for probes
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Deployment"
    not contains_element(input.parameters.excludedDeployments, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_]
    not contains_probes(container)
    msg := "The readinessProbe and livenessProbe are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "StatefulSet"
    not contains_element(input.parameters.excludedStatefulSets, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_]
    not contains_probes(container)
    msg := "The readinessProbe and livenessProbe are required."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "DaemonSet"
    not contains_element(input.parameters.excludedDaemonSets, input.review.object.metadata.name)
    container = input.review.object.spec.template.spec.containers[_]
    not contains_probes(container)
    msg := "The readinessProbe and livenessProbe are required."
}

