import  { Component } from 'react'
import ComingSoon from '../common/comingSoon'
import { handleLogError } from '../common/Helpers'


class Home extends Component {
  state = {
    isLoading: false,
    movies: []
  }

  async componentDidMount() {
    this.setState({ isLoading: true })
    try {
    } catch (error) {
      handleLogError(error)
    }
  }

  render() {
   
    return (
    <div className="App">
      <p> Demo page</p>
      <ComingSoon />
    </div>
  );
    
  }
}

export default Home