import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Rating = props => (
  <li> <div> {props.score} {props.review} by: {props.username} </div> </li>
)

Rating.propTypes = {
  score: PropTypes.number,
  review: PropTypes.string
}

class RatingsList extends React.Component {
  render() {
    const ratings = this.props.ratings.map((rating) => {
      return (<Rating key={rating.id} score={rating.score} review={rating.review} username={rating.username}/>)
    })
    return (
      <ul id="ratings">
      {ratings}
      </ul>
    )
  }
}
RatingsList.propTypes = {
  ratings: PropTypes.array
}
export default RatingsList;
