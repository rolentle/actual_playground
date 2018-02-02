brandon = Performer.create(name: 'Brandon Leon-Gambetta')
shr_network = PerformerGroup.create(name: 'SHR Network', performers: [brandon])
protean_city = Show.create(
  title: 'Protean City Comics',
  description: 'Protean City Comics is a weekly actual play podcast in the Masks: A New Generation game. It follows the lives of teenage super heroes in Protean City as they battle villains, seek to establish themselves as heroes, and struggle to find what kind of person they want to be.',
  status: 'approved',
  submitter: User.first,
  creator: shr_network
)
