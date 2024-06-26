// Copyright (c) 2022 WSO2 LLC. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/constraint;

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:CredentialsConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# Request to update container information
public type UpdateAContainerRequest record {
    # A unique user-provided identifier for a Shipwire Anywhere warehouse in an external system.
    string warehouseExternalId?;
    # A unique user-provided identifier for a container in an external system.
    string externalId?;
    # A unique identifier for the container in the Shipwire system. It can be standardized to be the dimensions of the container (length, width, height) and type.
    string name;
    # This is the type of container based on the contents stored in it.
    string 'type;
    # A boolean which indicates whether or not the warehouse can use the container for a particular customer for packaging
    int isActive;
    # A unique identifier for a Shipwire or Shipwire Anywhere warehouse. (See the warehouses API.)
    int warehouseId;
    # Basis is a parameter used to prioritize the use of some containers over others. To give preference to one container over another, assign a higher basis value.
    string basis;
    # It indicates that this container is used with a particular carrier service (eg. FDX 1D).
    string serviceSpecificCarrierCode?;
    # Dimensions
    record {} dimensions;
    # Values
    record {} values;
};

# Response for container update
public type UpdateAContainerResponse record {
    *PutPostResponseModel;
};

# Container dimensions
public type ContainerDimensions record {
    # This is the length of the container based on its Unit of Measurement (lengthUnit)
    @constraint:Number {minValue: 0.1, maxValue: 108}
    decimal length?;
    # This is the width of the container based on its Unit of Measurement (widthUnit)
    @constraint:Number {minValue: 0.1, maxValue: 108}
    decimal width?;
    # This is the height of the container based on its Unit of Measurement (heightUnit)
    @constraint:Float {minValue: 0.1, maxValue: 108}
    float height?;
    # This is the weight of the container based on its Unit of Measurement (weightUnit)
    float weight?;
    # This is the maximum weight that the container can hold based on its Unit of Measurement (maxWeightUnit)
    float maxWeight?;
    # This is the Unit of Measurement for Container length (e.g. inches)
    string lengthUnit?;
    # This is the Unit of Measurement for Container width (e.g. inches)
    string widthUnit?;
    # This is the Unit of Measurement for Container height (e.g. inches)
    string heightUnit?;
    # This is the Unit of Measurement for Container weight (e.g. pounds)
    string weightUnit?;
    # This is the Unit of Measurement for Container's max weight (e.g. pounds)
    string maxWeightUnit?;
};

public type GetResponseModel record {
    # This is the HTTP status code.
    int status?;
    # This is the HTTP status message.
    string message?;
    # A URL that gives more information about the linked resource. A null value would mean that no further information is available for that resource.
    string resourceLocation?;
};

# Get container details
public type GetContainersResponse record {
    *GetResponseModel;
};

public type Get404ResponseModel record {
    # This is the HTTP status code.
    int status?;
    # This is the HTTP status message.
    string message?;
    # A URL that gives more information about the linked resource. A null value would mean that no further information is available for that resource.
    string resourceLocation?;
};

# Container value
public type ContainerValue record {
    # This is the cost value for the container. During the carton selection phase for an order, Shipwire will first consider containers with a lower cost, even if chosing one will end up making the shipping cost comparatively higher. (i.e. Shipwire will chose a container 1 with a $0 cost over a container 2 with a $1 cost, even if the shipping cost for using container 1 is higher than it would be using container 2.)
    @constraint:Number {maxValue: 1000000.0}
    decimal costValue?;
    # This is the retail value for the container. Container retail value will be added to the shipping quote for the customer. If a merchant doesn't plan to charge customers for cartons/boxes, the container retail value should be set to $0.
    @constraint:Number {maxValue: 1000000.0}
    decimal retailValue?;
    # This is the currency used in determining cost value for the container.
    string costValueCurrency?;
    # This is the currency used in determining retail value for the container.
    string retailValueCurrency?;
};

# Get using invalid container Id
public type ContainerNotFound404Response record {
    *Get404ResponseModel;
};

# Container response model
public type ContainerResponseModel record {
    # A unique auto-generated ID assigned to each new container added to the Shipwire Platform.
    int id?;
    # A unique user-provided identifier for a container in an external system.
    string externalId?;
    # A unique identifier for the container in the Shipwire system. It can be standardized to be the dimensions of the container (length, width, height) and type.
    string name?;
    # This is the type of container based on the contents stored in it.
    string 'type?;
    # A boolean which indicates whether or not the warehouse can use the container for a particular customer for packaging
    int isActive?;
    # A unique identifier for a Shipwire or Shipwire Anywhere warehouse. (See the warehouses API.)
    int warehouseId?;
    # A unique user-provided identifier for a Shipwire Anywhere warehouse in an external system.
    string warehouseExternalId?;
    # Basis is a parameter used to prioritize the use of some containers over others. To give preference to one container over another, assign a higher basis value.
    string basis?;
    # It indicates that this container is used with a particular carrier service (eg. FDX 1D).
    string serviceSpecificCarrierCode?;
    # Dimensions
    ContainerresponsemodelDimensions dimensions?;
    # Values
    ContainerresponsemodelValues values?;
};

# Response post container creation
public type CreateANewContainerResponse record {
    *PutPostResponseModel;
};

public type PutPostResponseModel record {
    # This is the HTTP status code.
    int status?;
    # This is the HTTP status message.
    string message?;
    # A notification that warns the user of something or that serves as a caution. Eg. an externalId supplied greater than 32 characters.
    record {} warnings?;
    # A fatal error that prevents the user from performing some action. (e.g. invalid warehouseId specified when creating a container)
    record {} errors?;
    # A URL that gives more information about the linked resource. A null value would mean that no further information is available for that resource.
    string resourceLocation?;
};

# Dimensions
public type ContainerresponsemodelDimensions record {
    # Resource location
    string resourceLocation?;
    # Container dimensions
    ContainerDimensions 'resource?;
};

# Get container details
public type GetAContainerResponse record {
    # This is the HTTP status code.
    int status?;
    # This is the HTTP status message.
    string message?;
    # A URL that gives more information about the linked resource. A 'null' value would mean that no further information is available for that resource.
    string resourceLocation?;
    # Container response model
    ContainerResponseModel 'resource?;
};

# Values
public type ContainerresponsemodelValues record {
    # Resource location
    string resourceLocation?;
    # Container value
    ContainerValue 'resource?;
};

# Request to create new container
public type CreateANewContainerRequest record {
    # A unique user-provided identifier for a Shipwire Anywhere warehouse in an external system.
    string warehouseExternalId?;
    # A unique user-provided identifier for a container in an external system.
    string externalId?;
    # A unique identifier for the container in the Shipwire system. It can be standardized to be the dimensions of the container (length, width, height) and type.
    string name;
    # This is the type of container based on the contents stored in it.
    string 'type;
    # A boolean which indicates whether or not the warehouse can use the container for a particular customer for packaging
    int isActive;
    # A unique identifier for a Shipwire or Shipwire Anywhere warehouse. (See the warehouses API.)
    int warehouseId;
    # Basis is a parameter used to prioritize the use of some containers over others. To give preference to one container over another, assign a higher basis value.
    string basis;
    # It indicates that this container is used with a particular carrier service (eg. FDX 1D).
    string serviceSpecificCarrierCode?;
    # Dimensions
    record {} dimensions;
    # Values
    record {} values;
};
