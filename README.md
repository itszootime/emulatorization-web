# emulatorization-web

Rails-based frontend for the [emulatorization-api](https://github.com/itszootime/emulatorization-api).

## Requirements

- A running [emulatorization-api](https://github.com/itszootime/emulatorization-api) instance.
- [MongoDB](http://www.mongodb.org/).

## Installation

1. Clone repository.
2. Create `config/api.yml`. The example below assumes you have the API installed locally and running using the default configuration:

    ```yaml
    development: &development
      host: localhost
      port: 8080
      path: /emulatorization-api/api

    test: *development
    production: *development
    ```

3. Bundle.
4. Run `foreman start`. This starts both the web server and background worker.

## Further reading

Is available in my Ph.D. thesis, [Uncertainty Analysis in the Model Web (Jones, 2014)](https://research.aston.ac.uk/portal/en/theses/uncertainty-analysis-in-the-model-web(0f4f5b5d-aab9-4097-aff1-7efc31603613).html).
