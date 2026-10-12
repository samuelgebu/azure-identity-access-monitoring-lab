# Cleanup checklist — execution pending

Preserve required screenshots, configuration notes and test outputs first. These instructions have not been executed by the assistant.

1. If the reused VM is no longer needed tonight, stop it through Azure Portal and confirm **Stopped (deallocated)**. Guest shutdown alone is not equivalent; disks and public IPs may still incur charges.
2. For Project 3 teardown, remove the subscription diagnostic setting `diag-activity-to-law` before deleting its destination workspace.
3. Inspect the VM's DCR associations and remove only the association created for this project. Identify the new `msvmi-southafricanorth-vm-mgmt-01` rule and remove it only if no other resources use it. It may reside outside the Project 3 resource group.
4. Inspect `rg-identity-monitoring-lab` to confirm its resources are all disposable lab resources, then delete it when ready. This removes the workspace, alert and action group located there, plus resource-group-scoped role assignments. Deleting the workspace loses access to its collected evidence.
5. Remove the Azure Lab Reader test user and the `sg-azure-lab-readers` group when no longer needed. These are tenant objects and are not removed with the resource group.
6. Preserve `RG-CORP-NETWORK-LAB`, its VM and network configuration unless deliberately retiring the earlier project. Do not delete this group as part of Project 3 cleanup.
7. Inspect any default Azure Monitor workspace/resources created during earlier setup. Do not remove them without checking their use by other monitoring workloads.
8. Review Azure Cost Management after teardown for remaining VM, disk, public-IP and monitoring charges. Record completion date and evidence.

For retention instead of teardown, set a defined lab end date and review data collection/retention costs. Do not claim zero cost merely because the VM is deallocated.
