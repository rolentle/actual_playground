import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from 'axios';
import { Link } from 'react-router-dom'

import StarRating from './star_rating'

const ShowListItem = props => {
  const { title, avg_rating, id } = props.show;
  const path = `/shows/${id}`
  let avg_rating_display;
  if(avg_rating) {
    avg_rating_display = (<span>{avg_rating}
      <StarRating name={title} editing={false} value={avg_rating}/>
      </span>)
  } else {
    avg_rating_display = "Not yet rated"
  }

  return (<li><Link to={path}>{title}</Link> {avg_rating_display}</li>);
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
    axios.get(`/api/v1/shows`)
      .then(({data}) => data)
      .then((shows) => this.setState({shows}));
  }

  render() {
    return (<ShowList shows={this.state.shows} />)
  }
}

export default ShowListContainer;
