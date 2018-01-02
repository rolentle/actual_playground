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

  return (<div className="ui item">
    <span>
    <Link to={path}>{title}</Link>
    </span>
    <span>
    {avg_rating_display}
    </span>
    </div>);
}

ShowListItem.defaultProps = {
  show: {}
}

ShowListItem.propTypes = {
  show: PropTypes.object
}

const ShowList = props => {
  const shows = props.shows.map(show => <ShowListItem key={show.id}show={show} />);
  return(<div className="ui container">
    <div clasName="ui raised text container segment ">
    <h1 className="ui header">Top Shows</h1>
    <div className="ui ordered list" id="shows" >
    {shows}
    </div>
    </div>
    </div>);
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
