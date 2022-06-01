class GqlMemos {
  static String createMemo = '''
    mutation createMemo(\$memoableId: String!, \$memoableType: String!, \$content: String!){
      createMemo(
        input:{
        memoableId: \$memoableId
        memoableType: \$memoableType
        content: \$content
      }
      ){
        memo {
          id
          content
          createdAt
        }
      }
    }
    ''';
  static String listMemo = '''
    query memos(\$page: Int!){
      memos(page: \$page){
        id
        content
        createdAt
      }
    }
    ''';

  static String connectionMemo = '''
    query memosConnection(\$first: Int!, \$after: String){
      memosConnection(first: \$first, after: \$after) {
          pageInfo {
          endCursor
          startCursor
          hasNextPage
          hasPreviousPage
        },
        edges {
          node {
            id
            content
            createdAt
          }
        }
      }
    }
  ''';
}
