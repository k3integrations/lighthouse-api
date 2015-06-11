RSpec.describe Lighthouse::Ticket do
  let(:xml) { <<-EOF
    <tickets type="array">
      <total_pages>141</total_pages>
      <current_page>1</current_page>
      <ticket>
        <state>hold</state>
        <tag>bug</tag>
        <title>title</title>
      </ticket>
      <ticket>
        <state>closed</state>
        <tag>feature</tag>
        <title>title</title>
      </ticket>
    </tickets>
    EOF
  }

  before do
    stub_request(:get, 'http://test.lighthouseapp.com/projects/1/tickets.xml').
      to_return(status: 200, body: xml, headers: {})
  end

  context 'all' do
    let(:tickets) { Lighthouse::Ticket.all(params: { project_id: 1 }) }

    it 'will return two tickets' do
      expect(tickets.count).to eq 2
    end

    it 'will return ticket objects' do
      ticket = tickets.first

      expect(ticket.state).to eq 'hold'
      expect(ticket.tag).to eq 'bug'
      expect(ticket.title).to eq 'title'
    end
  end
end
