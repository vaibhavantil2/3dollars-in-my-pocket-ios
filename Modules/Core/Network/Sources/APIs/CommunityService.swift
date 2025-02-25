import Model

public protocol CommunityServiceProtocol {
    func fetchPopularStores(input: FetchPopularStoresInput) async -> Result<ContentsWithCursorResposne<StoreApiResponse>, Error>
    /// 동네 인기 가게가 활성화된 동네 목록 조회
    func fetchPopularStoreNeighborhoods() async -> Result<NeighborhoodsResponse, Error>
    /// 투표 신고 이유 목록 조회 (나중에 공용 API 로 통합 필요)
    func fetchPollReportReasons(type: FetchPollReportReasonsGroupType) async -> Result<PollReportReasonResponse, Error>
    /// 투표 신고
    func reportPoll(pollId: String, input: PollReportCreateRequestInput) async -> Result<String, Error>
    /// 투표 목록 조회
    func fetchPolls(input: FetchPollsRequestInput) async -> Result<ContentsWithCursorResposne<PollWithMetaApiResponse>, Error>
    /// 나의 투표 목록 조회
    func fetchMyPolls(input: CursorRequestInput) async -> Result<PollListWithUserPollMetaApiResponse, Error>
    // 투표 참여
    func createChoicePoll(pollId: String, input: PollChoiceCreateRequestInput) async -> Result<String, Error>
    /// 투표 단건 조회
    func fetchPoll(pollId: String) async -> Result<PollWithMetaApiResponse, Error>
    /// 유저 투표 정책 조회
    func fetchUserPollPolicy() async -> Result<PollPolicyApiResponse, Error>
    /// 투표에 등록된 댓글 목록 조회
    func fetchPollComments(pollId: String, input: CursorRequestInput) async -> Result<ContentsWithCursorResposne<PollCommentWithUserRecursiveApiResponse>, Error>
    /// 투표에 새로운 댓글 등록
    func createPollComment(pollId: String, input: CreatePollCommentRequestInput) async -> Result<IdResponseString, Error>
    /// 투표 등록
    func createPoll(input: PollCreateRequestInput) async -> Result<IdResponseString, Error>
    /// 투표 댓글 조회
    func fetchPollComment(pollId: String, commentId: String) async -> Result<PollCommentWithUserRecursiveApiResponse, Error>
    /// 투표 댓글 삭제
    func deletePollComment(pollId: String, commentId: String) async -> Result<String, Error>
    /// 댓글 신고
    func reportComment(pollId: String, commentId: String, input: PollCommentReportCreateRequestInput) async -> Result<String, Error>
    /// 투표 카테고리 목록 조회
    func fetchPollCategories() async -> Result<PollCategoryListApiReponse, Error>
}

public struct CommunityService: CommunityServiceProtocol {
    public init() { }

    public func fetchPopularStores(input: FetchPopularStoresInput) async -> Result<ContentsWithCursorResposne<StoreApiResponse>, Error> {
        let request = FetchPopularStoresRequest(requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchPopularStoreNeighborhoods() async -> Result<NeighborhoodsResponse, Error> {
        let request = FetchPopularStoreNeighborhoodsRequest()

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchPollReportReasons(type: FetchPollReportReasonsGroupType) async -> Result<PollReportReasonResponse, Error> {
        let request = FetchPollReportReasonRequest(type: type)
        
        return await NetworkManager.shared.request(requestType: request)
    }

    public func reportPoll(pollId: String, input: PollReportCreateRequestInput) async -> Result<String, Error> {
        let request = PollReportCreateRequest(pollId: pollId, requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchPolls(input: FetchPollsRequestInput) async -> Result<ContentsWithCursorResposne<PollWithMetaApiResponse>, Error> {
        let request = FetchPollsRequest(requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }
    
    public func fetchMyPolls(input: CursorRequestInput) async -> Result<PollListWithUserPollMetaApiResponse, Error> {
        let request = FetchMyPollsRequest(requestInput: input)
        return await NetworkManager.shared.request(requestType: request)
    }

    public func createChoicePoll(pollId: String, input: PollChoiceCreateRequestInput) async -> Result<String, Error> {
        let request = CreateChoicePollRequest(pollId: pollId, requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchPoll(pollId: String) async -> Result<PollWithMetaApiResponse, Error> {
        let request = FetchPollRequest(pollId: pollId)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchUserPollPolicy() async -> Result<PollPolicyApiResponse, Error> {
        let request = FetchPollUserPollPolicyRequest()

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchPollComments(pollId: String, input: CursorRequestInput) async -> Result<ContentsWithCursorResposne<PollCommentWithUserRecursiveApiResponse>, Error> {
        let request = FetchPollCommentsRequest(pollId: pollId, requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func createPollComment(pollId: String, input: CreatePollCommentRequestInput) async -> Result<IdResponseString, Error> {
        let request = CreatePollCommentRequest(pollId: pollId, requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func createPoll(input: PollCreateRequestInput) async -> Result<IdResponseString, Error> {
        let request = CreatePollRequest(requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func fetchPollComment(pollId: String, commentId: String) async -> Result<PollCommentWithUserRecursiveApiResponse, Error> {
        let request = FetchPollCommentRequest(pollId: pollId, commentId: commentId)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func deletePollComment(pollId: String, commentId: String) async -> Result<String, Error> {
        let request = DeletePollCommentRequest(pollId: pollId, commentId: commentId)

        return await NetworkManager.shared.request(requestType: request)
    }

    public func reportComment(pollId: String, commentId: String, input: PollCommentReportCreateRequestInput) async -> Result<String, Error> {
        let request = ReportPollCommentCreateRequest(pollId: pollId, commentId: commentId, requestInput: input)

        return await NetworkManager.shared.request(requestType: request)
    }
    
    public func fetchPollCategories() async -> Result<PollCategoryListApiReponse, Error> {
        let request = FetchPollCategoriesRequest()
        
        return await NetworkManager.shared.request(requestType: request)
    }
}
