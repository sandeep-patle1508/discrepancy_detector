# Descrepancy Detector
We publish our jobs to different marketing sources. To keep track of where the particular job is published, we create Campaign entity in database. Campaigns are periodically synchronized with 3rd party Ad Service.


A command line application which access Ad Service Campaigns API and local database to find out discrepancies between local and remote data.

This tool is comparing status and ad description of the campaigns between loal and remote and if any one of this field changed showing on the screen. Addition to it, it is also finding the campaign if it is present locally but not remotely.

You can find sample Ad campaigns API response here - https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df

## Installation
* install Ruby 2.5.1p57 version
* install PostgreSQL
* create two empty databases for development and local

## Setup
* clone the repository `git clone git@github.com:sandeep-patle1508/discrepancy_detector.git`
* `cd discrepancy_detector`
* `set the development and test database details in development.env and test.env root files`
* This command will create the campaigns table and insert initial data for development and test
`bin/setup`

## Usage
Currently this tool only able to find discrepancy for Campaigns data.

Pass the action type(campaign) with following command from root folder -
`./discrepancy_detector.rb <action_type>`

For example
`./discrepancy_detector.rb campaign`

It will display result in below format -
changed campaigns - Campaigns which has discrepany.
missing remote campaigns - Campaigns which present locally but not remotely

```
Discrepancy Result:
changed campaigns
[
  {
    "remote_reference": "1",
    "discrepancies": [
      {
        "status": {
          "remote": "enabled",
          "local": "disabled"
        }
      },
      {
        "description": {
          "remote": "Description for campaign 11",
          "local": "New Description for campaign 11"
        }
      }
    ]
  }
]

missing remote campaigns
[
  {
    "job_id": 104,
    "status": "enabled",
    "description": "Description for campaign 14"
  }
]
```

If there is no discrepancy between local and remote then you will see message like below on the screen -
```
Discrepancy Result:
No discrepancies found
```

## Test
After checking out the repo, run `bin/test` to run the tests. 

## Tools
* Ruby 2.5.1p57
* PostgreSQL
* activerecord
* pg
* HTTParty Gem
* Rspec
* webmock
* dotenv