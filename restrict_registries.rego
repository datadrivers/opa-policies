package restrictRegistries

# Pods
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Pod"
    container := input.review.object.spec.containers[_]
    satisfied := [good | repo = input.parameters.approvedRegistries[_] ; good = startswith(container.image, repo)]
    not any(satisfied)
    
    msg := sprintf("Container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, concat(", ", input.parameters.approvedRegistries)])
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "Pod"
    container := input.review.object.spec.initContainers[_]
    satisfied := [good | repo = input.parameters.approvedRegistries[_] ; good = startswith(container.image, repo)]
    not any(satisfied)
    
    msg := sprintf("Container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, concat(", ", input.parameters.approvedRegistries)])
}

# For CronJobs
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "CronJob"
    container := input.review.object.spec.jobTemplate.spec.template.spec.containers[_]
    satisfied := [good | repo = input.parameters.approvedRegistries[_] ; good = startswith(container.image, repo)]
    not any(satisfied)
    
    msg := sprintf("Container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, concat(", ", input.parameters.approvedRegistries)])
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind == "CronJob"
    container := input.review.object.spec.jobTemplate.spec.template.spec.initContainers[_]
    satisfied := [good | repo = input.parameters.approvedRegistries[_] ; good = startswith(container.image, repo)]
    not any(satisfied)
    
    msg := sprintf("Container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, concat(", ", input.parameters.approvedRegistries)])
}

# For Deployments, Daemonsets, StatefulSets, Jobs
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind != "Pod"
    input.review.object.kind != "Cronjob"
    container := input.review.object.spec.template.spec.containers[_]
    satisfied := [good | repo = input.parameters.approvedRegistries[_] ; good = startswith(container.image, repo)]
    not any(satisfied)
    
    msg := sprintf("Container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, concat(", ", input.parameters.approvedRegistries)])
}
violation[{"msg": msg, "details": {}}] {
    input.review.object.kind != "Pod"
    input.review.object.kind != "CronJob"
    container := input.review.object.spec.template.spec.initContainers[_]
    satisfied := [good | repo = input.parameters.approvedRegistries[_] ; good = startswith(container.image, repo)]
    not any(satisfied)
    
    msg := sprintf("Container <%v> has an invalid image repo <%v>, allowed repos are %v", [container.name, container.image, concat(", ", input.parameters.approvedRegistries)])
}

