FROM nginx:latest

# Install necessary tools (if needed, likely wget and unzip)
RUN apt-get update && apt-get install -y wget unzip

# Create a directory for the OneAgent
RUN mkdir -p /opt/dynatrace/oneagent

# Set environment variables (these will be overridden by the task definition)
ENV DT_PAAS_TOKEN="dt0c01.2YF6WSXM2XRFCRI767WWN2GT.FZN6QKC3JM634NBOMGR6GZBWDKTIQT6HOIKJMU6SN7TMJH7NZLWLIGKTEF4K4KYB"
ENV DT_ONEAGENT_OPTIONS="flavor=musl&include=all"
ENV DT_API_URL="https://rrx87749.live.dynatrace.com/api"

# Install OneAgent (using environment variables)
RUN ARCHIVE=$(mktemp) && \
    wget -O $ARCHIVE "$DT_API_URL/v1/deployment/installer/agent/unix/paas/latest?Api-Token=$DT_PAAS_TOKEN&$DT_ONEAGENT_OPTIONS" && \
    unzip -o -d /opt/dynatrace/oneagent $ARCHIVE && \
    rm -f $ARCHIVE

# Set LD_PRELOAD (critical for OneAgent to work)
ENV LD_PRELOAD="/opt/dynatrace/oneagent/agent/lib64/liboneagentproc.so"

COPY . .

# Install the necessary dependencies in your project (assuming package.json is in the copied directory)
RUN npm install
