import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from 'axios';
import { Link } from 'react-router-dom'

const ShowListItem = props => {
  const { title, avg_rating, id } = props.show;
  const path = `/shows/${id}`
  const avg_rating_text = avg_rating ? avg_rating : "Not yet rated"
  return (<li><Link to={path}>{title}</Link> {avg_rating_text}</li>);
}

ShowListItem.defaultProps = {
  show: {}
}

ShowListItem.propTypes = {
  show: PropTypes.object
}
const ShowList = props => {
  const shows = props.shows.map(show => <ShowListItem key={show.id}show={show} />);
  return(<ul id="shows" >{shows}</ul>);
}

ShowList.defaultProps = {
  shows: []
}

ShowList.propTypes = {
  shows: PropTypes.array
}

class ShowListContainer extends React.Component {
  constructor() {
    super();
    this.state = {
      shows: []
    };
  }

  componentDidMount() {
    axios.get(`/api/v1/shows`).then(function(response) {
      return response.data;
    }).then((shows) => {
      this.setState({shows});
    });
  }

  render() {
    return (<ShowList shows={this.state.shows} />)
  }
}

export default ShowListContainer;
