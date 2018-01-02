import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { Image, Item } from 'semantic-ui-react'

import StarRating from './star_rating'

const Rating = props => (
  <Item>
    <Item.Content>
      <Item.Header>{props.username}</Item.Header>
  <Item.Meta><span>{props.score}</span><StarRating name='' value={props.score} editing={false}/></Item.Meta>
      <Item.Description>{props.review}</Item.Description>
    </Item.Content>
  </Item>
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
      <Item.Group id="ratings">
        {ratings}
      </Item.Group>
    )
  }
}
RatingsList.propTypes = {
  ratings: PropTypes.array
}
export default RatingsList;
