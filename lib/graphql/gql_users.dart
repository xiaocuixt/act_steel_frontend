class GqlUsers {
  static String loginUser = '''
    mutation signinUser(\$email: String!, \$password: String!){
      signinUser(
        input:{
        email: \$email
        password: \$password
      }
      ){
        user {
          id
          email
        }
        token
      }
    }
    ''';
  static String signupUser = '''
    mutation signupUser(\$email: String!, \$password: String!, \$passwordConfirmation: String!){
      signupUser(
        input:{
          email: \$email
          password: \$password,
          passwordConfirmation: \$passwordConfirmation
        }
      ){
        user {
          id
          email
        }
        token
      }
    }
    ''';

  static String fetchMe = '''
    query me{
      me{
        mobile
        email
        avatarUrl
      }
    }
  ''';
  
  static String updateAvatar = '''
    mutation updateAvatar(\$avatar: Upload!){
      updateAvatar(
        input:{
          avatar: \$avatar
        }
      ){
        user {
          id
          email
          avatarUrl
        }
      }
    }
  ''';
}
