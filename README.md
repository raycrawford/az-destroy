
# AZ-Destroy
az-destroy.bash deletes Azure resource groups that match a command-line-provided string across Azure Subscriptions.  The Azure CLI was used because of it's simple `--no-wait` flag that parallelizes and runs the command in the background.

## Getting Started

* Clone repository to your local system
* `chmod u+x ./az-destroy.bash`
* Create a `.gitignore` to prohibit `secrets.bash` from being commited
* Create a secrets file by `cp ./secrets.bash.template ./secrets.bash` and update with your Azure Tenant, Subscription and Service Prinicipal information

### Prerequisites

* bash
* Azure CLI
* A Service Principal that has Subsciption Contributor access to all Subsciptions of interest
* an updated (and .gitignored) `secrets.bash`

### Use

`./az-destroy <resource group name fragment>`

**Example:**

```
./az-destroy cloud1017
Looking for resource groups starting with cloud1017
RESOURCES TO DELETE:
=> <Subscription ID #1>
==>  cloud1017a
==>  mycloud1017a
==>  cloud1017c
=> <Subscription ID #2>
==>  cloud1017b
==>  thecloud1017b
IS THIS OKAY?  DO YOU WANT TO CONTINUE? (y/n)
```

## Contributing

Feel free to fork, clone or, if you'd like to contribute back, just issue a PR.

## Authors

**Ray Crawford** - *Initial work* - [GitHub](https://github.com/raycrawford)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* My awesome collegues at [Cardinal Solutions Group](https://github.com/cardinal-solutions)
