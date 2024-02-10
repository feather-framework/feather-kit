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
    public struct Page: Codable, Sendable {

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
            self.limit = limit ?? Default.limit
            self.offset = offset ?? Default.offset
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

    public struct Query<
        S: Codable & Sendable
    >: Codable, Sendable {
        public let page: Page
        public let search: String?
        public let sort: S?
        public let order: Order?

        public init(
            page: List.Page,
            search: String? = nil,
            sort: S? = nil,
            order: List.Order? = nil
        ) {
            self.page = page
            self.search = search
            self.sort = sort
            self.order = order
        }
    }

    public struct Result<
        I: Codable & Sendable,
        S: Codable & Sendable
    >: Codable, Sendable {
        public let items: [I]
        public let count: Int
        public let query: Query<S>
        
        public init(items: [I], count: Int, query: Query<S>) {
            self.items = items
            self.count = count
            self.query = query
        }
    }
}
