# Django High Availability
## With Docker Compose

The goal is to deploy web application without down the server, using green blue deployment technique.
## Flow

### Build Docker Image
Navigate to your terminal and `cd` to project directory.
```bash
export CUR_TAG:0.0.1
export NEW_TAG:0.0.1
make build-django
```

### Running Project
```bash
make initial
```

Now image with tag 0.0.1 should be running.

### Test Deploying New Tag
Open a new terminal window or tap, make sure you are in the project directory.

```bash
export NEW_TAG:0.0.2
make build-django
make test-status
```

After running `make test-status` it will loop curling API, to see if we deploy new tag and service down or not.

### Deploy new version
Open a new terminal window or tap, make sure you are in the project directory.
```bash
export NEW_TAG:0.0.2
make deploy
```

# License
Copyright (c) 2020 Khemanorak Khath

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
OR OTHER DEALINGS IN THE SOFTWARE.
