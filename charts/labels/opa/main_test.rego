package labels

namespace = {
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
        "labels": {
            "app": "helloworld"
        },
        "name": "helloworld",
    }
}

test_good {
    requiredLabelKeys = ["app"]
    results := violation with input.review.object as namespace with input.parameters.requiredLabelKeys as requiredLabelKeys

    count(results) == 0
}


test_missing {
    requiredLabelKeys = ["owner", "stage"]
    results := violation with input.review.object as namespace with input.parameters.requiredLabelKeys as requiredLabelKeys

    count(results) == 1
    results[i].msg == "You must provide labels: {\"owner\", \"stage\"}"
    results[i].details == {"missing_labels": {"owner", "stage"}}
}