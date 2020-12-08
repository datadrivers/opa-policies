package restrictLoadbalancers

contains(array, elem) {
    array[_] = elem
}

violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Service"
    input.review.object.spec.type == "LoadBalancer"
    not contains(input.parameters.approvedServices, input.review.object.metadata.name)
    msg := "This service with type Loadbalancer is not allowed."
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Service"
    input.review.object.spec.type == "NodePort"
    not contains(input.parameters.approvedServices, input.review.object.metadata.name)
    msg := "This service with type NodePort is not allowed."
}

