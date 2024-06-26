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

# This is a generated connector for [Notion API v1](https://developers.notion.com/reference/intro) OpenAPI Specification. 
# Notion API provides capability to access all-in-one workspace where you can write, plan, collaborate and get organized. it has components such as notes, databases, kanban boards, wikis, calendars, and reminders. You can connect these  components to take notes, add tasks, manage projects & more. Notion provides the building blocks and you can  create your own layouts and toolkit to get work done. This ballerina connector allows you to connect Notion through its [REST API](https://developers.notion.com/docs).
@display {label: "Notion", iconPath: "icon.png"}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    # The connector initialization requires setting the API credentials. 
    # Create a [Notion account](https://www.notion.so/)  and obtain tokens following [this guide](https://developers.notion.com/docs/authorization).
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.notion.com") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Retrieve block children
    #
    # + id - block children ID 
    # + pageSize - Page size 
    # + notionVersion - API Version 
    # + return - 200 Success - Retrieve block children 
    remote isolated function retrieveBlockChildren(string id, string? pageSize = (), string notionVersion = "2021-05-13") returns BlockChildrenResponse|error {
        string resourcePath = string `/v1/blocks/${getEncodedUri(id)}/children`;
        map<anydata> queryParam = {"page_size": pageSize};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        BlockChildrenResponse response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Append block children
    #
    # + id - block children ID 
    # + notionVersion - API Version 
    # + return - 200 Success - Append block children 
    remote isolated function appendBlockChildren(string id, PageUpdateRequestBody payload, string notionVersion = "2021-05-13") returns ChildBlockContent|error {
        string resourcePath = string `/v1/blocks/${getEncodedUri(id)}/children`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        ChildBlockContent response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # List all databases
    #
    # + startCursor - If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results. 
    # + pageSize - The number of items from the full list desired in the response. Maximum- 100 
    # + notionVersion - API Version 
    # + return - 200 Success - List all databases 
    remote isolated function listAllDatabases(string? startCursor = (), int? pageSize = (), string notionVersion = "2021-05-13") returns DatabaseResponse|error {
        string resourcePath = string `/v1/databases`;
        map<anydata> queryParam = {"start_cursor": startCursor, "page_size": pageSize};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        DatabaseResponse response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Create a database
    #
    # + notionVersion - API Version 
    # + payload - Page information 
    # + return - 200 Success - Create a database 
    remote isolated function createDatabase(DatabaseBodyParams payload, string notionVersion = "2021-05-13") returns DatabaseBodyParams|error {
        string resourcePath = string `/v1/databases`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        DatabaseBodyParams response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Retrieve a database
    #
    # + id - Database ID 
    # + notionVersion - API Version 
    # + return - 200 Success - Retrieve a database 
    remote isolated function retrieveDatabase(string id, string notionVersion = "2021-05-13") returns Database|error {
        string resourcePath = string `/v1/databases/${getEncodedUri(id)}`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        Database response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Query a Database
    #
    # + id - Database ID 
    # + notionVersion - API Version 
    # + return - 200 Success - Query a Database (Single Filter) 
    remote isolated function queryDatabase(string id, DatabaseContent payload, string notionVersion = "2021-05-13") returns DatabaseResponse|error {
        string resourcePath = string `/v1/databases/${getEncodedUri(id)}/query`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        DatabaseResponse response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Create a page
    #
    # + notionVersion - API Version 
    # + payload - Page information 
    # + return - 200 Success - Create Page 
    remote isolated function createPage(PageBodyParams payload, string notionVersion = "2021-05-13") returns PageResponse|error {
        string resourcePath = string `/v1/pages`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        PageResponse response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
    # Retrieve a Page
    #
    # + id - Page ID 
    # + notionVersion - API Version 
    # + return - 200 Success - Retrieve a Page 
    remote isolated function retrievePage(string id, string notionVersion = "2021-05-13") returns PageResponse|error {
        string resourcePath = string `/v1/pages/${getEncodedUri(id)}`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        PageResponse response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Update Page properties 
    #
    # + id - Page ID 
    # + notionVersion - API Version 
    # + return - 200 Success - Update Page properties 
    remote isolated function updatePageProperties(string id, PageContent payload, string notionVersion = "2021-05-13") returns PageUpdatedProperties|error {
        string resourcePath = string `/v1/pages/${getEncodedUri(id)}`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        PageUpdatedProperties response = check self.clientEp->patch(resourcePath, request, httpHeaders);
        return response;
    }
    # List all users
    #
    # + startCursor - If supplied, this endpoint will return a page of results starting after the cursor provided. If not supplied, this endpoint will return the first page of results. 
    # + pageSize - The number of items from the full list desired in the response. Maximum- 100 
    # + notionVersion - API Version 
    # + return - 200 Success - List all users 
    remote isolated function listAllUsers(string? startCursor = (), int? pageSize = (), string notionVersion = "2021-05-13") returns PaginatedUsers|error {
        string resourcePath = string `/v1/users`;
        map<anydata> queryParam = {"start_cursor": startCursor, "page_size": pageSize};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        PaginatedUsers response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Retrieve a user
    #
    # + id - User ID 
    # + notionVersion - API Version 
    # + return - 200 Success - Retrieve a user 
    remote isolated function retrieveUser(string id, string notionVersion = "2021-05-13") returns User|error {
        string resourcePath = string `/v1/users/${getEncodedUri(id)}`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        User response = check self.clientEp->get(resourcePath, httpHeaders);
        return response;
    }
    # Searches all pages and child pages
    #
    # + notionVersion - API Version 
    # + return - 200 Success - List all user 
    remote isolated function searchPages(string notionVersion = "2021-05-13") returns json|error {
        string resourcePath = string `/v1/search`;
        map<any> headerValues = {"Notion-Version": notionVersion};
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        //TODO: Update the request as needed;
        json response = check self.clientEp->post(resourcePath, request, httpHeaders);
        return response;
    }
}
