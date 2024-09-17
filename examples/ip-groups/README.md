# Ip Groups

This deploys ip groups used by collection group rules

## Types

```hcl
ip_groups = map(object({
  name = string
  cidr = list(string)
}))
```
