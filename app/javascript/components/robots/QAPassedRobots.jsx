import React from 'react';
import { Table } from 'react-bootstrap'

class QAPassedRobots extends React.Component {
  constructor(props) {
    super(props)
  }

  addToShipment(robot, index, category) {
    this.props.onAddToShipment(robot, index, category);
  }

  renderRobots() {
    let robots = this.props.robots.map((robot, index) => {
      return(
        <tr key={robot.id} className={`qa-passed-list-robot-${robot.id}`}>
          <td>
            <button
              className="btn btn-primary"
              onClick={ this.addToShipment.bind(this, robot, index, "qa_passed") }>
              Add to shipment
            </button>
          </td>
          <td>{robot.id}</td>
          <td>{robot.name}</td>
          <td>{robot.configuration.hasSentience ? 'Yes' : 'No'}</td>
          <td>{robot.configuration.hasWheels ? 'Yes' : 'No'}</td>
          <td>{robot.configuration.hasTracks ? 'Yes' : 'No'}</td>
          <td>{robot.configuration.numberOfRotors}</td>
          <td>{robot.configuration.color}</td>
          <td>{robot.configuration.statuses.join(', ')}</td>
        </tr>
      )
    });

    return robots;
  }

  render() {
    return(
      <div className="col-xs-12 qa-passed">
        <h3>QA Passed</h3>
        <div className="table-responsive shippable">
          <Table>
            <thead>
              <tr>
                <th>Action</th>
                <th>ID</th>
                <th>Name</th>
                <th>Has Sentience</th>
                <th>Has Wheels</th>
                <th>Has Tracks</th>
                <th>Number of rotors</th>
                <th>Color</th>
                <th>Statuses</th>
              </tr>
            </thead>
            <tbody>
              { this.renderRobots() }
            </tbody>
          </Table>
        </div>
      </div>
    );
  }
}

export default QAPassedRobots;
