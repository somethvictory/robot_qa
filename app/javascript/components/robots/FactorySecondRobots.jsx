import React from 'react';
import { Table } from 'react-bootstrap'

class FactorySecondRobots extends React.Component {
  constructor(props) {
    super(props)
  }

  addToShipment(robot, index, category) {
    this.props.onAddToShipment(robot, index, category);
  }

  renderRobots() {
    let robots = this.props.robots.map((robot, index) => {
      return(
        <tr key={robot.id} className={`factory-second-list-robot-${robot.id}`}>
          <td>
            <button
              className="btn btn-primary"
              onClick={ this.addToShipment.bind(this, robot, index, "factory_second") }>
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
      <div className="col-xs-12 factory-second">
        <h3>Factory Second</h3>
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

export default FactorySecondRobots;
