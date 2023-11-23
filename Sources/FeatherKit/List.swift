//
//  List.swift
//  FeatherKit
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// A generic List namespace for complex list requests and responses
public enum List {

    /// Order of the list
    public enum Order: String, Codable, Sendable {
        /// Ascending order
        case asc
        /// Descending order
        case desc
    }

    /// Pagination information about the List
    public enum Page {

        /// Default pagination values
        public enum Default {
            /// Default page limit value
            ///
            /// Default value: 50
            public static var limit: Int = 50
            /// Default page offset value
            ///
            /// Default value: 0
            public static var offset: Int = 0
        }

        /// Pagination info for the List requests
        public struct Request: Codable, Sendable {
            /// Limit query value
            ///
            /// Defaults ot the `Page.Default.limit` value if not present
            public let limit: Int
            /// Offset query value
            ///
            /// Defaults ot the `Page.Default.offset` value if not present
            public let offset: Int

            public init(
                limit: Int? = nil,
                offset: Int? = nil
            ) {
                self.limit = limit ?? Page.Default.limit
                self.offset = offset ?? Page.Default.offset
            }
        }

        /// Pagination response for the List requests
        public struct Response: Codable, Sendable {
            /// The page limit response
            public let limit: Int
            /// The page offset response
            public let offset: Int
            /// The number of total pages
            public let count: Int

            public init(
                limit: Int,
                offset: Int,
                count: Int
            ) {
                self.limit = limit
                self.offset = offset
                self.count = count
            }
        }
    }

    public struct Sort<T: Codable & Sendable>: Codable, Sendable {
        public let by: T
        public let order: Order

        public init(by: T, order: Order) {
            self.by = by
            self.order = order
        }
    }

    public struct Filter<T: Codable & Sendable>: Codable, Sendable {
        /// The relationship between the filter query elements
        public enum Relation: String, Codable, Sendable {
            /// And relation
            case and
            /// Or relation
            case or
        }

        public struct Query: Codable, Sendable {
            public enum Method: String, Codable, Sendable {
                case equals
                case like
            }

            public let method: Method
            public let key: T
            public let value: String

            public init(method: Method, key: T, value: String) {
                self.method = method
                self.key = key
                self.value = value
            }
        }

        public let relation: Relation
        public let query: [Query]

        public init(relation: Relation = .and, query: [Query] = []) {
            self.relation = relation
            self.query = query
        }
    }

    public struct Request<
        S: Codable & Sendable,
        F: Codable & Sendable
    >: Codable, Sendable {
        public let page: Page.Request
        public let filter: Filter<F>
        public let sort: [Sort<S>]

        public init(
            page: Page.Request = .init(),
            sort: [Sort<S>] = [],
            filter: Filter<F> = .init()
        ) {
            self.page = page
            self.filter = filter
            self.sort = sort
        }
    }

    public struct Response<
        I: Codable & Sendable,
        S: Codable & Sendable,
        F: Codable & Sendable
    >: Codable, Sendable {
        public let items: [I]
        public let count: Int
        public let page: Page.Response
        public let sort: [Sort<S>]
        public let filter: Filter<F>

        public init(
            items: [I],
            count: Int,
            page: Page.Response,
            sort: [Sort<S>],
            filter: Filter<F>
        ) {
            self.items = items
            self.count = count
            self.page = page
            self.sort = sort
            self.filter = filter
        }
    }
}
