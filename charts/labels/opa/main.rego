package labels

violation[{"msg": msg, "details": {"missing_labels": missing}}] {
    provided := {label | input.review.object.metadata.labels[label]}
    required := {label | label := input.parameters.requiredLabelKeys[_]}
    missing := required - provided
    count(missing) > 0
    msg := sprintf("You must provide labels: %v", [missing])
}