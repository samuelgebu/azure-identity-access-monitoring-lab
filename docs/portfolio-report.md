# Secure Azure Administration: Implementation Report

**Samuel Gebu — 11–12 October 2026**

## Objective and scope

Demonstrate practical administration of identity, permissions, audit logs and virtual-machine telemetry in a personal Azure environment. The project reuses a Windows VM from a preceding network-security lab. Results are based on the user's Azure screenshots and PowerShell output, not simulated evidence.

## Implementation

### Identity and least privilege

Created `rg-identity-monitoring-lab` and an Assigned security group, `sg-azure-lab-readers`. Assigned Reader to that group on the project resource group. Created Azure Lab Reader without administrative roles and added it to the group. A separate browser session showed the user could view the group; a attempted tag update was rejected with `AuthorizationFailed`.

This demonstrates the tested permission boundary for resource-group viewing and tag writes. It does not claim an exhaustive test of every Azure operation or unrelated inherited permissions.

### Administrative auditing

Created `law-identity-monitoring-lab` in South Africa North and configured subscription-level Administrative Activity Log export with `diag-activity-to-law`. An administrator tag change produced Start and Success records in AzureActivity. KQL filtered the collected subscription data to the project resource group and exposed operation, timestamp, status and caller.

The earlier denied test was not visible in the inspected Activity Log view; its error screenshot remains the evidence of denial. Administrative export concerns Azure resource-management actions, not Entra user/group audit logs or Windows guest events.

### Alerting

Created `alert-lab-tag-changes` using the Write tags Activity Log signal and configured `ag-lab-email`. The inspected alert fired at 23:09 UTC on 11 October for `Microsoft.Resources/tags/write` against the project resource group, initiated by the administrator. The receiver's enrollment confirmation was received.

Actual tag-change alert email delivery remains unverified. The final success-status filter also requires confirmation from the rule's condition configuration. These limitations are explicitly retained for honest portfolio reporting.

### Workload identity

Enabled the system-assigned identity on `VM-MGMT-01`, assigned it Reader on the project group, and tested it inside the VM. PowerShell obtained an ARM token from Azure Instance Metadata Service and performed an authenticated GET of the group. The response displayed `rg-identity-monitoring-lab` and `southafricanorth`. No embedded user password or client secret was used by the script.

### Guest monitoring

Configured classic log-based metrics to the existing workspace, selected a new VM monitoring DCR and left recommended VM alerts disabled. A Heartbeat query returned the Windows VM with a recent timestamp. InsightsMetrics showed collected logical-disk measurements including free space, read throughput and read latency. The screenshots verify ingestion; they do not establish that the VM is healthy against business thresholds or prove a load-test result.

## Operational troubleshooting

The subnet-level `NSG-MANAGEMENT` allowed RDP from a single public IP. When that address no longer matched the client's current public IP, RDP failed. Updating the source `/32` restored access. The NIC's empty NSG field did not establish absence of subnet security; the lower page showed the subnet NSG.

A broken multiline PowerShell paste caused `-Uri` to execute independently and prevented token retrieval. Single-line commands resolved the error and the authenticated read succeeded.

## Outcome

Verified group-based read access, a denied tag modification, administrative log export, a fired alert, workload authentication and VM telemetry ingestion. Email alert delivery and cleanup are pending. The lab is appropriate evidence of hands-on Azure administration and troubleshooting, rather than a claim of production deployment experience.

## Evidence and repeatability

Use the evidence index and included KQL/PowerShell files. The README contains the exact architecture relationship and validation matrix. Preserve genuine screenshots separately; sanitize copies before publishing.

## Official references

- https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal
- https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-create-activity-log-alert-rule
- https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/action-groups
- https://learn.microsoft.com/en-us/entra/identity/managed-identities-azure-resources/tutorial-windows-vm-access
- https://learn.microsoft.com/en-us/azure/azure-monitor/vm/vminsights-enable
