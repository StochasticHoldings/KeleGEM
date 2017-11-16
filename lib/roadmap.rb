module Roadmap
  def get_roadmaps(roadmap_id)
    get_roadmaps = self.class.get("/roadmaps/#{roadmap_id}",headers: {"authorization" => @auth_token})
    JSON.parse(get_roadmaps.body)
  end

  def get_checkpoints(checkpoint_id)
    get_roadmaps = self.class.get("/checkpoints/#{checkpoint_id}",headers: {"authorization" => @auth_token})
    JSON.parse(get_roadmaps.body)
  end
end
