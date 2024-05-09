//  Created by Geoff Pado on 10/19/23.
//  Copyright © 2023 Cocoatype, LLC. All rights reserved.

import XCTest

@testable import Editing
@testable import Observations

final class RestoredRedactionTests: XCTestCase {
#if canImport(UIKit)
    func testInitIgnoresEmptyShapes() throws {
        let data = try XCTUnwrap(Data(base64Encoded: """
            eyJjb2xvciI6IlluQnNhWE4wTUREVUFRSURCQVVHQndwWUpIWmxjbk5wYjI1WkpHRnlZMmhwZG1WeVZDUjBiM0JZSkc5aWFtVmpkSE1TQUFHR29GOFFEMDVUUzJWNVpXUkJjbU5vYVhabGN0RUlDVlJ5YjI5MGdBR2tDd3diSEZVa2JuVnNiTmNORGc4UUVSSVRGQlVXRnhnWkdsOFFGVlZKUTI5c2IzSkRiMjF3YjI1bGJuUkRiM1Z1ZEZkVlNWZG9hWFJsVjFWSlFXeHdhR0ZXSkdOc1lYTnpYeEFSVlVsVGVYTjBaVzFEYjJ4dmNrNWhiV1ZYVGxOWGFHbDBaVnhPVTBOdmJHOXlVM0JoWTJVUUFpSUFBQUFBSWorQUFBQ0FBNEFDUVRBUUJGcGliR0ZqYTBOdmJHOXkweDBlSHlBaEkxb2tZMnhoYzNOdVlXMWxXQ1JqYkdGemMyVnpXeVJqYkdGemMyaHBiblJ6VjFWSlEyOXNiM0tpSUNKWVRsTlBZbXBsWTNTaEpGZE9VME52Ykc5eUFBZ0FFUUFhQUNRQUtRQXlBRGNBU1FCTUFGRUFVd0JZQUY0QWJRQ0ZBSTBBbFFDY0FMQUF1QURGQU1jQXpBRFJBTk1BMVFEWEFOa0E1QURyQVBZQVwvd0VMQVJNQkZnRWZBU0VBQUFBQUFBQUNBUUFBQUFBQUFBQWxBQUFBQUFBQUFBQUFBQUFBQUFBQktRPT0iLCJwYXRocyI6WyJZbkJzYVhOME1ERFVBUUlEQkFVR0J3cFlKSFpsY25OcGIyNVpKR0Z5WTJocGRtVnlWQ1IwYjNCWUpHOWlhbVZqZEhNU0FBR0dvRjhRRDA1VFMyVjVaV1JCY21Ob2FYWmxjdEVJQ1ZSeWIyOTBnQUdyQ3d3akp5OURSRVZKVDFSVkpHNTFiR3pjRFE0UEVCRVNFeFFWRmhjWUdSb2JIQjBlSHlBaEd5SWJYeEFpVlVsQ1pYcHBaWEpRWVhSb1ZYTmxjMFYyWlc1UFpHUkdhV3hzVW5Wc1pVdGxlVjhRR1ZWSlFtVjZhV1Z5VUdGMGFFMXBkR1Z5VEdsdGFYUkxaWGxmRUJ4VlNVSmxlbWxsY2xCaGRHaE1hVzVsU205cGJsTjBlV3hsUzJWNVZpUmpiR0Z6YzE1d1lYUm9VSEp2Y0dWeWRHbGxjMThRR1ZWSlFtVjZhV1Z5VUdGMGFFTkhVR0YwYUVSaGRHRkxaWGxmRUJoVlNVSmxlbWxsY2xCaGRHaE1hVzVsVjJsa2RHaExaWGxmRUJ4VlNVSmxlbWxsY2xCaGRHaE1hVzVsUkdGemFGQm9ZWE5sUzJWNVh4QVhWVWxDWlhwcFpYSlFZWFJvUm14aGRHNWxjM05MWlhsZkVCdFZTVUpsZW1sbGNsQmhkR2hNYVc1bFEyRndVM1I1YkdWTFpYbFlkWE5sY2tsdVptOWZFQ05WU1VKbGVtbGxjbEJoZEdoTWFXNWxSR0Z6YUZCaGRIUmxjbTVEYjNWdWRFdGxlUWdpUVNBQUFCQUFnQXFBQklBQ0lqK0FBQUFpQUFBQUFDSVwvR1ptYWdBalNKQkFsSmxkT1V5NWtZWFJoVHhCSUFBQUFBQUVBQUFBQUFLQkFBQUNnUUFFQUFBQUJBQUFBQUFDZ1FBQUFvRUFCQUFBQUFRQUFBQUFBb0VBQUFLQkFBUUFBQUFFQUFBQUFBS0JBQUFDZ1FBUUFBQUFBQUFBQWdBUFNLQ2txSzFva1kyeGhjM051WVcxbFdDUmpiR0Z6YzJWelhVNVRUWFYwWVdKc1pVUmhkR0dqTEMwdVhVNVRUWFYwWVdKc1pVUmhkR0ZXVGxORVlYUmhXRTVUVDJKcVpXTjAyekF4TWpNMEVEVTJOemc1T2hrWkd6MCtHU0FaUVRwZkVCaHdZWFJvVUhKdmNHVnlkR2xsYzE5c1lYTjBVRzlwYm5SZkVCeHdZWFJvVUhKdmNHVnlkR2xsYzE5cmJtOTNjMGxtUTJ4dmMyVmtYeEFjY0dGMGFGQnliM0JsY25ScFpYTmZhR0Z6Um1seWMzUlFiMmx1ZEY4UUlYQmhkR2hRY205d1pYSjBhV1Z6WDJOaFkyaGxaRVZzWlcxbGJuUkRiM1Z1ZEY4UUZYQmhkR2hRY205d1pYSjBhV1Z6WDJKdmRXNWtjMThRRzNCaGRHaFFjbTl3WlhKMGFXVnpYMmhoYzB4aGMzUlFiMmx1ZEY4UUczQmhkR2hRY205d1pYSjBhV1Z6WDNSaGJtZGxiblJCZEVWdVpGOFFGM0JoZEdoUWNtOXdaWEowYVdWelgybHpRMnh2YzJWa1h4QVZjR0YwYUZCeWIzQmxjblJwWlhOZmFYTkdiR0YwWHhBWmNHRjBhRkJ5YjNCbGNuUnBaWE5mWm1seWMzUlFiMmx1ZElBRkNBaUFCb0FIQ0FnSmdBVldlekFzSURCOVh4QVVlM3RwYm1Zc0lHbHVabjBzSUhzd0xDQXdmWDNTS0NsR1IxOFFGbFZKUW1WNmFXVnlVR0YwYUZCeWIzQmxjblJwWlhPaVNDNWZFQlpWU1VKbGVtbGxjbEJoZEdoUWNtOXdaWEowYVdWejAwcExFRXhOVGxkT1V5NXJaWGx6V2s1VExtOWlhbVZqZEhPZ29JQUowaWdwVUZGZkVCTk9VMDExZEdGaWJHVkVhV04wYVc5dVlYSjVvMUpUTGw4UUUwNVRUWFYwWVdKc1pVUnBZM1JwYjI1aGNubGNUbE5FYVdOMGFXOXVZWEo1MGlncFZWWmNWVWxDWlhwcFpYSlFZWFJvb2xjdVhGVkpRbVY2YVdWeVVHRjBhQUFJQUJFQUdnQWtBQ2tBTWdBM0FFa0FUQUJSQUZNQVh3QmxBSDRBb3dDXC9BTjRBNVFEMEFSQUJLd0ZLQVdRQmdnR0xBYkVCc2dHM0Fia0J1d0c5QWI4QnhBSEpBYzRCMEFIVkFkMENLQUlxQWk4Q09nSkRBbEVDVlFKakFtb0Njd0tLQXFVQ3hBTGpBd2NESHdNOUExc0RkUU9OQTZrRHF3T3NBNjBEcndPeEE3SURzd08wQTdZRHZRUFVBOWtEOGdQMUJBNEVGUVFkQkNnRUtRUXFCQ3dFTVFSSEJFc0VZUVJ1QkhNRWdBU0RBQUFBQUFBQUFnRUFBQUFBQUFBQVdBQUFBQUFBQUFBQUFBQUFBQUFBQkpBPSJdfQ==
            """))
        let redaction = try JSONDecoder().decode(Redaction.self, from: data)

        XCTAssertEqual(redaction.parts.count, 0)
    }

    func testInitIncludesNonEmptyShapes() throws {
        let data = try XCTUnwrap(Data(base64Encoded: """
            eyJjb2xvciI6IlluQnNhWE4wTUREVUFRSURCQVVHQndwWUpIWmxjbk5wYjI1WkpHRnlZMmhwZG1WeVZDUjBiM0JZSkc5aWFtVmpkSE1TQUFHR29GOFFEMDVUUzJWNVpXUkJjbU5vYVhabGN0RUlDVlJ5YjI5MGdBR2tDd3diSEZVa2JuVnNiTmNORGc4UUVSSVRGQlVXRnhnWkdsOFFGVlZKUTI5c2IzSkRiMjF3YjI1bGJuUkRiM1Z1ZEZkVlNWZG9hWFJsVjFWSlFXeHdhR0ZXSkdOc1lYTnpYeEFSVlVsVGVYTjBaVzFEYjJ4dmNrNWhiV1ZYVGxOWGFHbDBaVnhPVTBOdmJHOXlVM0JoWTJVUUFpSUFBQUFBSWorQUFBQ0FBNEFDUVRBUUJGcGliR0ZqYTBOdmJHOXkweDBlSHlBaEkxb2tZMnhoYzNOdVlXMWxXQ1JqYkdGemMyVnpXeVJqYkdGemMyaHBiblJ6VjFWSlEyOXNiM0tpSUNKWVRsTlBZbXBsWTNTaEpGZE9VME52Ykc5eUFBZ0FFUUFhQUNRQUtRQXlBRGNBU1FCTUFGRUFVd0JZQUY0QWJRQ0ZBSTBBbFFDY0FMQUF1QURGQU1jQXpBRFJBTk1BMVFEWEFOa0E1QURyQVBZQVwvd0VMQVJNQkZnRWZBU0VBQUFBQUFBQUNBUUFBQUFBQUFBQWxBQUFBQUFBQUFBQUFBQUFBQUFBQktRPT0iLCJwYXRocyI6WyJZbkJzYVhOME1ERFVBUUlEQkFVR0J3cFlKSFpsY25OcGIyNVpKR0Z5WTJocGRtVnlWQ1IwYjNCWUpHOWlhbVZqZEhNU0FBR0dvRjhRRDA1VFMyVjVaV1JCY21Ob2FYWmxjdEVJQ1ZSeWIyOTBnQUdyQ3d3akp5OURSRVZKVDFSVkpHNTFiR3pjRFE0UEVCRVNFeFFWRmhjWUdSb2JIQjBlSHlBaEd5SWJYeEFpVlVsQ1pYcHBaWEpRWVhSb1ZYTmxjMFYyWlc1UFpHUkdhV3hzVW5Wc1pVdGxlVjhRR1ZWSlFtVjZhV1Z5VUdGMGFFMXBkR1Z5VEdsdGFYUkxaWGxmRUJ4VlNVSmxlbWxsY2xCaGRHaE1hVzVsU205cGJsTjBlV3hsUzJWNVZpUmpiR0Z6YzE1d1lYUm9VSEp2Y0dWeWRHbGxjMThRR1ZWSlFtVjZhV1Z5VUdGMGFFTkhVR0YwYUVSaGRHRkxaWGxmRUJoVlNVSmxlbWxsY2xCaGRHaE1hVzVsVjJsa2RHaExaWGxmRUJ4VlNVSmxlbWxsY2xCaGRHaE1hVzVsUkdGemFGQm9ZWE5sUzJWNVh4QVhWVWxDWlhwcFpYSlFZWFJvUm14aGRHNWxjM05MWlhsZkVCdFZTVUpsZW1sbGNsQmhkR2hNYVc1bFEyRndVM1I1YkdWTFpYbFlkWE5sY2tsdVptOWZFQ05WU1VKbGVtbGxjbEJoZEdoTWFXNWxSR0Z6YUZCaGRIUmxjbTVEYjNWdWRFdGxlUWdpUVNBQUFCQUFnQXFBQklBQ0lqK0FBQUFpQUFBQUFDSVwvR1ptYWdBalNKQkFsSmxkT1V5NWtZWFJoVHhCSUFBQUFBQUVBQUFBQUFBQUFBQUFBQUFFQUFBQUJBQUFBQUFBQUFBQUFvRUFCQUFBQUFRQUFBQUFBb0VBQUFLQkFBUUFBQUFFQUFBQUFBS0JBQUFBQUFBUUFBQUFBQUFBQWdBUFNLQ2txSzFva1kyeGhjM051WVcxbFdDUmpiR0Z6YzJWelhVNVRUWFYwWVdKc1pVUmhkR0dqTEMwdVhVNVRUWFYwWVdKc1pVUmhkR0ZXVGxORVlYUmhXRTVUVDJKcVpXTjAyekF4TWpNMEVEVTJOemc1T2hrWkd6MCtHU0FaUVRwZkVCaHdZWFJvVUhKdmNHVnlkR2xsYzE5c1lYTjBVRzlwYm5SZkVCeHdZWFJvVUhKdmNHVnlkR2xsYzE5cmJtOTNjMGxtUTJ4dmMyVmtYeEFjY0dGMGFGQnliM0JsY25ScFpYTmZhR0Z6Um1seWMzUlFiMmx1ZEY4UUlYQmhkR2hRY205d1pYSjBhV1Z6WDJOaFkyaGxaRVZzWlcxbGJuUkRiM1Z1ZEY4UUZYQmhkR2hRY205d1pYSjBhV1Z6WDJKdmRXNWtjMThRRzNCaGRHaFFjbTl3WlhKMGFXVnpYMmhoYzB4aGMzUlFiMmx1ZEY4UUczQmhkR2hRY205d1pYSjBhV1Z6WDNSaGJtZGxiblJCZEVWdVpGOFFGM0JoZEdoUWNtOXdaWEowYVdWelgybHpRMnh2YzJWa1h4QVZjR0YwYUZCeWIzQmxjblJwWlhOZmFYTkdiR0YwWHhBWmNHRjBhRkJ5YjNCbGNuUnBaWE5mWm1seWMzUlFiMmx1ZElBRkNBaUFCb0FIQ0FnSmdBVldlekFzSURCOVh4QVVlM3RwYm1Zc0lHbHVabjBzSUhzd0xDQXdmWDNTS0NsR1IxOFFGbFZKUW1WNmFXVnlVR0YwYUZCeWIzQmxjblJwWlhPaVNDNWZFQlpWU1VKbGVtbGxjbEJoZEdoUWNtOXdaWEowYVdWejAwcExFRXhOVGxkT1V5NXJaWGx6V2s1VExtOWlhbVZqZEhPZ29JQUowaWdwVUZGZkVCTk9VMDExZEdGaWJHVkVhV04wYVc5dVlYSjVvMUpUTGw4UUUwNVRUWFYwWVdKc1pVUnBZM1JwYjI1aGNubGNUbE5FYVdOMGFXOXVZWEo1MGlncFZWWmNWVWxDWlhwcFpYSlFZWFJvb2xjdVhGVkpRbVY2YVdWeVVHRjBhQUFJQUJFQUdnQWtBQ2tBTWdBM0FFa0FUQUJSQUZNQVh3QmxBSDRBb3dDXC9BTjRBNVFEMEFSQUJLd0ZLQVdRQmdnR0xBYkVCc2dHM0Fia0J1d0c5QWI4QnhBSEpBYzRCMEFIVkFkMENLQUlxQWk4Q09nSkRBbEVDVlFKakFtb0Njd0tLQXFVQ3hBTGpBd2NESHdNOUExc0RkUU9OQTZrRHF3T3NBNjBEcndPeEE3SURzd08wQTdZRHZRUFVBOWtEOGdQMUJBNEVGUVFkQkNnRUtRUXFCQ3dFTVFSSEJFc0VZUVJ1QkhNRWdBU0RBQUFBQUFBQUFnRUFBQUFBQUFBQVdBQUFBQUFBQUFBQUFBQUFBQUFBQkpBPSJdfQ==
            """))
        let redaction = try JSONDecoder().decode(Redaction.self, from: data)

        XCTAssertEqual(redaction.parts.count, 1)
    }
#endif
}

private struct MockTextObservation: TextObservation {
    let bounds: Shape
}
